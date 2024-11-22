#!/bin/bash

# Only add delay if script is being run at boot
if [ "$(systemctl is-system-running)" == "starting" ]; then
    sleep 10
fi

# Source ROS2 workspaces
source /opt/ros/humble/setup.bash
source ~/discower_ws/install/setup.bash

# Wait for connection to be established
# while true; do
#     NUM_PUBLISHERS=$(ros2 topic info /$(hostname)/fmu/out/vehicle_status | grep -c "Publisher count:")
    
#     # If the number of publishers is greater than 0, break the loop
#     if (( NUM_PUBLISHERS > 0 )); then
#         break
#     fi
    
#     # Wait for a short duration before checking again
#     sleep 1
# done

# echo "Detected a publisher for /$(hostname)/fmu/out/vehicle_status"

ros2 run vehicle_mocap_odom vehicle_mocap_odom_node