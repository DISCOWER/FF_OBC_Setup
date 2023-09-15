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

1. Install Micro-XRCE-agent

   ```
   cd /home/discower/
   git clone https://github.com/eProsima/Micro-XRCE-DDS-Agent.git
   cd Micro-XRCE-DDS-Agent
   mkdir build
   cd build
   cmake ..
   make
   sudo make install
   sudo ldconfig /usr/local/lib/
   ```

2. Set up the ROS2 workspace *PX4-Space-Systems_ROS2_WS*

   ```
   git clone https://github.com/DISCOWER/PX4-Space-Systems_ROS2_WS.git /home/discower/PX4-Space-Systems_ROS2_WS
   cd ~/PX4-Space-Systems_ROS2_WS/
   colcon build
   ```


3. Add the startup service

   ```
   sudo cp /home/discower/FF_OBC_Setup/startup/services/startup_px4_comm.service /etc/systemd/system/
   sudo systemctl daemon-reload
   sudo systemctl enable startup_px4_comm
   sudo systemctl start startup_px4_comm
   ```


## For RC controller (optional)

Add the startup service

```
sudo cp /home/discower/FF_OBC_Setup/startup/services/startup_px4_rc_controller.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable startup_px4_rc_controller
sudo systemctl start startup_px4_rc_controller
```

