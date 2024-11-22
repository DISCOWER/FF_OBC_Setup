# FF_OBC_Setup
Setup routine and scripts for DISCOWER's FreeFlyers' onboard computers (OBC).

## Clone this repo

```
git clone https://github.com/DISCOWER/FF_OBC_Setup.git /home/discower/FF_OBC_Setup
```

## Set the hostname

1. Change the hostname.
   ```
   sudo hostnamectl set-hostname <hostname>
   ```
2. Edit the /etc/hosts file.
   ```
   sudo vim /etc/hosts
   ```
   Find the line that starts with 127.0.0.1 or 127.0.1.1 followed by the old hostname (probably discower) and change it to the new hostname. Save and close the file.

## Install ROS2 Humble

1. Follow installation instructions at https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debians.html

2. Source ROS2 by default

   ```
   echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
   ```

## Set up ROS2 Workspace
1. Set up workspace. Clone and build required ros2 packages.
   ```
   mkdir -p ~/discower_ws/src/
   cd ~/discower_ws/src/
   git clone git@github.com:DISCOWER/px4_msgs.git
   git clone git@github.com:DISCOWER/srl_vehicle_mocap_odom.git
   cd ~/discower_ws
   colcon build
   ```

## Install Micro-XRCE-DDS-Agent
 Install with snap-store
```
sudo snap install micro-xrce-dds-agent
```

## Add the startup service

```
sudo cp /home/discower/FF_OBC_Setup/services/px4_comm.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable px4_comm
sudo systemctl start px4_comm
```

## Optional: Set up SAM gripper

1. Install Micro-ROS-agent

   ```
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

   ```
   sudo cp /home/discower/FF_OBC_Setup/services/gripper_comm.service /etc/systemd/system/
   sudo systemctl daemon-reload
   sudo systemctl enable gripper_comm
   sudo systemctl start gripper_comm
   ```

