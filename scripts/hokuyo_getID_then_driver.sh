#!/bin/sh
# ensure the device is ready before launching the "hokuyo_node" driver

set -e # stop at first error

rosrun hokuyo_node getID /dev/ttyACM0

# the hokuyo laser node, -120 degrees -> 120 degrees
# sudo chmod a+rwx /dev/ttyACM0
rosrun hokuyo_node hokuyo_node

