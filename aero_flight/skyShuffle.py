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
    print("1")
    telloInstance.flip_right()
    time.sleep(2)
    telloInstance.flip_left()
    time.sleep(2)
    telloInstance.flip_back()
    time.sleep(2)
    telloInstance.land()

def danceTwo():
    print("2")
    telloInstance.send_rc_control(-30, 0, 30, 0) # left
    time.sleep(2)
    telloInstance.send_rc_control(30, 0, -60, 0) # right
    time.sleep(2)
    telloInstance.send_rc_control(-30, 0, 30, 0) # back to center
    time.sleep(2)
    telloInstance.send_rc_control(0, 0, 0, 0)
    time.sleep(0.5)
    telloInstance.flip_back()
    time.sleep(2)
    telloInstance.land()

def danceThree():
    print("3")
    telloInstance.flip_back()
    # might need sleep here?
    telloInstance.flip_back()
    telloInstance.send_rc_control(0, 0, 40, 0) # move up
    time.sleep(2)
    telloInstance.send_rc_control(0, 0, 0, 0)
    time.sleep(0.5)
    telloInstance.flip_right()
    telloInstance.flip_left()
    telloInstance.land()

def main():
    # random.choice(danceOne(), danceTwo(), danceThree())
    random_function = random.choice([danceOne, danceTwo, danceThree])
    random_function()

main()
# danceOne()
# danceTwo()
# danceThree()

# make condition to check if drone battery is above 50%. only execute if above 60%.




