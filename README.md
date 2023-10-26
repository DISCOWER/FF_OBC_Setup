# FF_OBC_Setup
Setup routine and scripts for DISCOWER's FreeFlyers' onboard computers (OBC).

## Clone this repo

```
git clone https://github.com/DISCOWER/FF_OBC_Setup.git /home/discower/FF_OBC_Setup
```

## Install ROS2 Foxy

1. Follow installation instructions at https://docs.ros.org/en/foxy/Installation/Ubuntu-Install-Debians.html

2. Source ROS2 by default

   ```
   echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc
   ```

## PX4 at startup scripts and comm.

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

2. Set up the ROS2 workspace *PX4-Space-Systems_ROS2_WS*

   ```
   git clone https://github.com/DISCOWER/PX4-Space-Systems_ROS2_WS.git /home/discower/PX4-Space-Systems_ROS2_WS
   cd ~/PX4-Space-Systems_ROS2_WS/
   colcon build
   ```


3. Add the startup service

   ```
   sudo cp /home/discower/FF_OBC_Setup/services/px4_comm.service /etc/systemd/system/
   sudo systemctl daemon-reload
   sudo systemctl enable px4_comm
   sudo systemctl start px4_comm
   ```


## For SAM Gripper

Add the startup service

```
sudo cp /home/discower/FF_OBC_Setup/services/gripper_comm.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable gripper_comm
sudo systemctl start gripper_comm
```

