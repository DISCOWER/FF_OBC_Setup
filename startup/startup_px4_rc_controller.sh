#!/bin/bash

# Only add delay if script is being run at boot
if [ "$(systemctl is-system-running)" == "starting" ]; then
    sleep 10
fi

# Source ROS2 workspaces
source /opt/ros/foxy/setup.bash
source /home/discower/PX4-Space-Systems_ROS2_WS/install/setup.bash


# Run the RC controller which subscribes to RcChannels from PX4
ros2 run px4_thruster_controller px4_rc_offboard_ctl > /dev/null 2>&1 &
