from djitellopy import tello
import cv2
import numpy as np
import time
import random

def danceOne(telloInstance):
    print("1")
    telloInstance.flip_right()
    time.sleep(2)
    telloInstance.flip_left()
    time.sleep(2)
    telloInstance.flip_back()
    time.sleep(2)
    # telloInstance.land()

def danceTwo(telloInstance):
    print("2")
    telloInstance.send_rc_control(-30, 0, 0, 0) # left
    time.sleep(2)
    telloInstance.send_rc_control(30, 0, 0, 0) # right
    time.sleep(2)
    telloInstance.send_rc_control(-30, 0, 0, 0) # back to center
    time.sleep(2)
    telloInstance.send_rc_control(0, 0, 0, 0)
    time.sleep(0.5)
    telloInstance.flip_back()
    time.sleep(2)
    # telloInstance.land()

def danceThree(telloInstance):
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
    # telloInstance.land()

def main(telloInstance):
    # random.choice(danceOne(), danceTwo(), danceThree())
    random_function = random.choice([danceOne, danceTwo, danceThree])
    random_function(telloInstance)

if __name__ == '__main__':
    telloInstance = tello.Tello()
    telloInstance.connect()
    bat  = print(telloInstance.get_battery())
    telloInstance.takeoff()
    
    time.sleep(2)
    
    main(telloInstance)
    telloInstance.land()
    # danceOne()
    # danceTwo()
    # danceThree()

    # make condition to check if drone battery is above 50%. only execute if above 60%.