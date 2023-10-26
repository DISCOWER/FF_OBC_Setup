#!/bin/bash

# Only add delay if script is being run at boot
if [ "$(systemctl is-system-running)" == "starting" ]; then
    sleep 10
fi

# Source ROS2 workspaces
source /opt/ros/foxy/setup.bash
source /home/discower/microros_ws/install/setup.bash

# Run MicroXRCEAgent
#ros2 run micro_ros_agent micro_ros_agent serial --dev /dev/ttyTEENSY -r /home/discower/FF_OBC_Setup/scripts/custom_qos.refs > /dev/null 2>&1 &
ros2 run micro_ros_agent micro_ros_agent serial --dev /dev/ttyTEENSY > /dev/null 2>&1 &
