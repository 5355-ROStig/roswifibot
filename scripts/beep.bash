#!/bin/bash
# emit a beep when the robot is ready
# the following flags are supported
# --firewire --hokuyo --kinect --odom

sleep 3
rostopic list
if [[ $? -ne 0 ]]; then # rosmaster not found
  beep -f 200 -r 3 # tut tut tut
  exit
fi

# wait while first odometry not received
if [[ $* == *--odom* ]]; then
  echo "Waiting for odom..."
  rostopic echo -n 1 /odom >> /dev/null
fi

# wait while first Firewire image not received
if [[ $* == *--firewire* ]]; then
  echo "Waiting for Firewire camera..."
  rostopic echo -n 1 /image_raw >> /dev/null
fi

# wait while first Hokuyo laser scan not received
if [[ $* == *--hokuyo* ]]; then
  echo "Waiting for Hokuyo laser..."
  rostopic echo -n 1 /scan >> /dev/null
fi

# wait while first Kinect images not received
if [[ $* == *--kinect* ]]; then
  echo "Waiting for Kinect camera..."
  rostopic echo -n 1 /camera/depth/image >> /dev/null
  rostopic echo -n 1 /camera/rgb/image_color >> /dev/null
fi

# nice beep sound
echo "Nice! We received all required topics."
beep -f 1000 -r 2 -n -r 5 -l 10 --new
