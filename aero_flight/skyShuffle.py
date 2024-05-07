from djitellopy import tello
import cv2
import numpy as np
import time
import random

telloInstance = tello.Tello()
telloInstance.connect()
bat  = print(telloInstance.get_battery())
telloInstance.takeoff()
#telloInstance.streamon()
time.sleep(2)

def danceOne():
    telloInstance.flip_right()
    telloInstance.flip_left()
    telloInstance.flip_back()
    telloInstance.land()

def danceTwo():
    telloInstance.send_rc_control(15, 0, 0, 0) # left
    telloInstance.send_rc_control(-30, 0, 0, 0) # right
    telloInstance.send_rc_control(15, 0, 0, 0) # back to center
    telloInstance.flip_back()
    telloInstance.land()

def danceThree():
    telloInstance.flip_back()
    #might need sleep here?
    telloInstance.flip_back()
    telloInstance.send_rc_control(0, 0, 15, 0) # move up
    telloInstance.flip_right()
    telloInstance.flip_left()
    telloInstance.land()

def main():
    random.choices(danceOne, danceTwo, danceThree)

main()

# make condition to check if drone battery is above 50%. only execute if above 60%.




