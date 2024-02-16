import KeyPressModule as KP
from djitellopy import Tello
from time import sleep
import sys

KP.init()
me = Tello()
me.connect()
print(me.get_battery())


def get_keyboard_input():
    lr, fb, ud, yv = 0, 0, 0, 0
    speed = 50
    if KP.getKey("LEFT"):
        lr = -speed
    elif KP.getKey("RIGHT"):
        lr = speed

    if KP.getKey("UP"):
        fb = speed
    elif KP.getKey("DOWN"):
        fb = -speed

    if KP.getKey("w"):
        ud = speed
    elif KP.getKey("s"):
        ud = -speed

    if KP.getKey("a"):
        yv = speed
    elif KP.getKey("d"):
        yv = -speed

    if KP.getKey("q"):
        me.land()
    if KP.getKey("e"):
        me.takeoff()

    if KP.getKey("p"):
        sys.exit()

    return [lr, fb, ud, yv]


while True:
    vals = get_keyboard_input()
    me.send_rc_control(vals[0], vals[1], vals[2], vals[3])
    sleep(0.05)
