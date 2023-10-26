#!/bin/bash

# Only add delay if script is being run at boot
if [ "$(systemctl is-system-running)" == "starting" ]; then
    sleep 10
fi

# Source ROS2 workspaces
source /opt/ros/foxy/setup.bash
source /home/discower/PX4-Space-Systems_ROS2_WS/install/setup.bash
source /home/discower/microros_ws/install/setup.bash

# Run Micro-ROS Agent
ros2 run micro_ros_agent micro_ros_agent udp4 -p 8888 > /dev/null 2>&1 &

while true; do
    NUM_PUBLISHERS=$(ros2 topic info /$(hostname)/fmu/out/vehicle_status | grep -c "Publisher count:")
    
    # If the number of publishers is greater than 0, break the loop
    if (( NUM_PUBLISHERS > 0 )); then
        break
    fi
    
    # Wait for a short duration before checking again
    sleep 1
done

echo "Detected a publisher for /$(hostname)/fmu/out/vehicle_status"

# Run the PX4-Commander
ros2 run px4_commander px4_commander > /dev/null 2>&1 &
