roswifibot
==========

ROS Driver for Wifibot lab mobile robot.
More information at
  http://www.wifibot.com
It is based on low-level "libwifibot" driver, available here:
  http://sourceforge.net/projects/libwifibot/
  and here
  https://svn.code.sf.net/p/roswifibot/code/trunk/
"libwifibot" is wrapped within this ROS package.

This package is a fork of the original "roswifibot" package, available on SourceForge:
  http://sourceforge.net/projects/roswifibot/
The fork has been ported to catkin and maintained with recent versions of ROS.
Retro-compatibility has been kept with rosmake
(older versions of ROS, for instance fuerte).

Features:
  - "wifibot_node":     low-level robot control
  - "hokuyo_node":      low-level Hokuyo laser driver
  - "camera1394":       low-level Firewire camera driver
  - "turtlebot_teleop": keyboard-based teleoperation
  - "rviz":             vizualisation


Licence
-------
BSD


Authors
-------
Original authors according to the "manifest": claire, jean-charles

Fork maintainer: Arnaud Ramey (arnaud.a.ramey@gmail.com)


Compile and install
-------------------
Dependencies with ROS Fuerte:

$ sudo apt-get install  ros-fuerte-robot-model  ros-fuerte-navigation  ros-fuerte-laser-drivers  ros-fuerte-viz ros-fuerte-perception ros-fuerte-camera1394

Compile with catkin:

$ catkin_make --only-pkg-with-deps roswifibot

Compile with rosmake (older versions of ROS, for instance fuerte):

$ cd cmake ; bash package2rosmake.bash
$ rosmake roswifibot

Note: to revert the package back to catkin-compliant:

$ cd cmake ; bash package2catkin.bash


Run
---
Run the drivers (robot driver, camera, Hokuyo):

$ roslaunch roswifibot robot_launch.launch

Run joypad-based teleoperation
(in a second terminal, with "robot_launch.launch" already launched):

$ roslaunch roswifibot joy_teleop.launch

Run keyboard-based teleoperation
(in a second terminal, with "robot_launch.launch" already launched):

$ roslaunch roswifibot keyboard_teleop.launch

Run "rviz", the vizualisation tool
(in a second terminal, with "robot_launch.launch" already launched):

$ roslaunch roswifibot rviz.launch


Troubleshooting
---------------
### **Problem**: roscore error.
  When you launch
  $ roscore

  Error on screen:
  Param xml is <param command="rosversion ros" name="rosversion"/>
  Invalid <param> tag: Cannot load command parameter [rosversion]: command [rosversion ros] returned with code [1].

**Solution**:
  http://answers.ros.org/question/44996/cannot-run-roscore-due-to-error-in-rosversion/

  $ sudo apt-get install python-rospkg


### **Problem**: Acces denied to devices (robot or Hokuyo).

**Solution**:
  $ sudo chmod a+rwx /dev/ttyS* /dev/ttyACM*


### **Problem**: Connexion with the robot is slow (several seconds).
  Few TF messages:
    "$ rostopic hz"
  returns less than 100Hz.
  Topic "/odom" is not published.

**Cause**:
  Another executable is already connected with the robot.

**Solution**:
  kill all processes "robot_server*".
  Run:
    $ ps aux | grep robot_server
  and kill all all associated PIDs.
  Then stop and relaunch the launch file.


### **Problem**: Firewire camera is not recognized.

**Solution**:
  Run "coriander" and check camera is recognized.


### **Problem**: Hokuyo laser range finder dies.
  When launching "wifibot_node", the Hokyuo device is suddenly turned off,
  (or  any other plugged on the robot);
  the device "/dev/ttyACM0" disappears

**Solution**:
  http://wiki.ros.org/hokuyo_node/Troubleshooting
  The problem is in fact linked with the electrical relays of the Wifibot.
  The orders sent to the robot can cut off the relays
  (electrical supplies) for the devices plugged on the robot.
  By default, the orders shut down these relays and so the Hokyuo device
  is shut down.

  The "wifibot_node" ROS driver has been modified to enable such configuration.
  For instance, set as command-line argument "_relay1:=true"
  to activate the first relay.
  Note: at the driver level, you could call "setRelays(true, true, true)"
  to enable them.

