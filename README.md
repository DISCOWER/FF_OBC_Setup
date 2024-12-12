# FF_OBC_Setup
Setup routine and scripts for DISCOWER's FreeFlyers' onboard computers (OBC).

## Clone this repo

```bash
git clone https://github.com/DISCOWER/FF_OBC_Setup.git /home/discower/FF_OBC_Setup
```

## Set the hostname

1. Change the hostname.
   ```bash
   sudo hostnamectl set-hostname <hostname>
   ```
2. Edit the /etc/hosts file.
   ```bash
   sudo vim /etc/hosts
   ```
   Find the line that starts with 127.0.0.1 or 127.0.1.1 followed by the old hostname (probably discower) and change it to the new hostname. Save and close the file.

## Setup WiFi 7

1. Install `iwlwifi-modules` with
   ```bash
   sudo apt install -y iwlwifi-modules
   ```
2. Setup boot support for the module
   ```bash
   echo iwlwifi | sudo tee -a /etc/modules
   ```


## Install ROS2 Humble

1. Follow installation instructions at https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debians.html

2. Source ROS2 by default

   ```bash
   echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
   ```

## Set up ROS2 Workspace
1. Set up workspace. Clone and build required ros2 packages.
   ```bash
   mkdir -p ~/discower_ws/src/
   cd ~/discower_ws/src/
   git clone git@github.com:DISCOWER/px4_msgs.git
   git clone git@github.com:DISCOWER/srl_vehicle_mocap_odom.git
   cd ~/discower_ws
   colcon build
   ```

## Install Micro-XRCE-DDS-Agent
Install with snap-store

```bash
sudo snap install micro-xrce-dds-agent --edge
```

## Add the startup service

```bash
sudo cp /home/discower/FF_OBC_Setup/services/* /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable px4_comm
sudo systemctl start px4_comm
sudo systemctl enable vehicle_mocap_odom
sudo systemctl start vehicle_mocap_odom
```

## Add MAVProxy and Mavlink Router

Start by installing MAVProxy:
```bash
sudo apt-get install python3-dev python3-opencv python3-wxgtk4.0 python3-pip python3-matplotlib python3-lxml python3-pygame
pip3 install PyYAML mavproxy --user
echo 'export PATH="$PATH:$HOME/.local/bin"' >> ~/.bashrc
sudo usermod -a -G dialout discower
source ~/.bashrc
```

Run it with:
```bash
mavproxy.py --master=/dev/ttyPX4
```

Then, install mavlink-router:
```bash
sudo apt install git meson ninja-build pkg-config gcc g++ systemd
sudo pip3 install meson
git clone git@github.com:mavlink-router/mavlink-router.git ~/mavlink_router
cd ~/mavlink_router
git submodule update --init --recursive
meson setup build .
sudo ninja -C build install
sudo mkdir -p /etc/mavlink-router/
sudo cp /home/discower/FF_OBC_Setup/mavlink.conf/* /etc/mavlink-router/
```

## Add PX4 Rules for USB Mavlink interface

```bash
sudo cp /home/discower/FF_OBC_Setup/rules/* /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo udevadm trigger
```

## Optional: Set up SAM gripper

1. Install Micro-ROS-agent

   ```bash
   # Source the ROS 2 installation
   source /opt/ros/foxy/setup.bash

   # Create a workspace and download the micro-ROS tools
   mkdir ~/microros_ws
   cd ~/microros_ws
   git clone -b $ROS_DISTRO https://github.com/micro-ROS/micro_ros_setup.git src/micro_ros_setup

   # Update dependencies using rosdep
   sudo apt update && rosdep update
   rosdep install --from-paths src --ignore-src -y

   # Install pip
   sudo apt-get install python3-pip
   
   # Build micro-ROS tools and source them
   colcon build
   source install/local_setup.bash

   # Download micro-ROS agent packages
   ros2 run micro_ros_setup create_agent_ws.sh
   
   # Build step
   ros2 run micro_ros_setup build_agent.sh
   ```

2. Add the startup service

   ```bash
   sudo cp /home/discower/FF_OBC_Setup/services/gripper_comm.service /etc/systemd/system/
   sudo systemctl daemon-reload
   sudo systemctl enable gripper_comm
   sudo systemctl start gripper_comm
   ```

