from djitellopy import tello
import cv2
import numpy as np
import time

telloInstance = tello.Tello()
telloInstance.connect()
print(telloInstance.get_battery())
telloInstance.takeoff()
#telloInstance.streamon()
time.sleep(2)
telloInstance.flip_right()
telloInstance.flip_left()
telloInstance.flip_back()

#time.sleep(2)
telloInstance.land()

# telloInstance.send_rc_control(0, 0, 0, 0) # left
# telloInstance.send_rc_control(0, 0, 0, 0) # right
# telloInstance.send_rc_control(0, 0, 0, 0) # back to center

# make condition to check if drone battery is above 50%. only execute if above 60%.
# add 2 more "dances" and allow drone to choose randomly which one to do
# do 1 where it goes left, right, back to center, front flip
# play around with other flips




