#!/bin/bash

# Only add delay if script is being run at boot
if [ "$(systemctl is-system-running)" == "starting" ]; then
    sleep 10
fi

# Source ROS2 workspaces
source /opt/ros/foxy/setup.bash
source /home/discower/PX4-Space-Systems_ROS2_WS/install/setup.bash
source /home/discower/microros_ws/install/local_setup.bash

# Run MicroXRCEAgent
# MicroXRCEAgent udp4 -p 8888 > /dev/null 2>&1 &
ros2 run micro_ros_agent micro_ros_agent udp4 -p 8888 > /dev/null 2>&1 &
