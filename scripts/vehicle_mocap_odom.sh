#!/bin/bash

# Only add delay if script is being run at boot
if [ "$(systemctl is-system-running)" == "starting" ]; then
    sleep 10
fi

# Source ROS2 workspaces
source /opt/ros/humble/setup.bash
source ~/discower_ws/install/setup.bash

# Run the vehicle_mocap_odom node
ros2 run vehicle_mocap_odom vehicle_mocap_odom_node 2>&1 &