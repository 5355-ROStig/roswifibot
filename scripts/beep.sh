#!/bin/sh
# emit a beep when the robot is ready

# wait while first robot odom not received
echo "Waiting for odom..."
rostopic echo -n 1 /odom >> /dev/null
# wait while first Kinect images not received
echo "Waiting for Kinect camera..."
rostopic echo -n 1 /camera/depth/image >> /dev/null
rostopic echo -n 1 /camera/rgb/image_color >> /dev/null
# wait while first Firewire image not received
echo "Waiting for Firewire camera..."
rostopic echo -n 1 /image_raw >> /dev/null
# wait while first Hokuyo laser scan not received
echo "Waiting for Hokuyo laser..."
rostopic echo -n 1 /scan >> /dev/null
# nice beep sound
beep -f 1000 -r 2 -n -r 5 -l 10 --new
