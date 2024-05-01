import KeyPressModule as KP
from djitellopy import Tello
from time import sleep
import cv2
import sys

KP.init()
me = Tello()
me.connect()
print(me.get_battery())

def params_from_Flutter():
    # Placeholder method that will be updated to parse the data received from Flutter or may be deleted if found that it is not needed
    print('X and Y coordinates')
    get_keyboard_input(-16,67,-16,67) # forward
    get_keyboard_input(-73,2,-73,2) # left
    get_keyboard_input(-11,-66,-11,-66) # backward
    get_keyboard_input(74,-13,74,-13) # right


def get_keyboard_input(x1, y1, x2, y2):
    lr, fb, ud, yv = 0, 0, 0, 0
    speed = 40

    # x1, x2, y1, and y2 if statements that will mimic the movement interpretation using Joystick Coordinates from Flutter
    if x1 > 0 and y1 > -x1 and y1 < x1: print(f'{x1},{y1}:right') 
    if x1 < 0 and y1 < -x1 and y1 > x1: print(f'{x1},{y1}:left') 
    if y1 > 0 and y1 > x1 and y1 > -x1: print(f'{x1},{y1}:forward') 
    if y1 < 0 and y1 < x1 and y1 < -x1: print(f'{x1},{y1}:backward') 

    if x2 > 0 and y2 > -x2 and y2 < x2: print(f'{x2},{y2}:rotateRight') 
    if x2 < 0 and y2 < -x2 and y2 > x2: print(f'{x2},{y2}:rotateLeft') 
    if y2 > 0 and y2 > x2 and y2 > -x2: print(f'{x2},{y2}:up') 
    if y2 < 0 and y2 < x2 and y2 < -x2: print(f'{x2},{y2}:down') 
    
    # Original if statements for interpreting Keyboard Inputs using KeyPressModule
    if KP.getKey("LEFT"): lr = -speed
    elif KP.getKey("RIGHT"): lr = speed
    if KP.getKey("UP"): fb = speed
    elif KP.getKey("DOWN"): fb = -speed

    if KP.getKey("w"): ud = speed
    elif KP.getKey("s"): ud = -speed
    if KP.getKey("a"): yv = speed
    elif KP.getKey("d"): yv = -speed

    if KP.getKey("e"): me.land()
    if KP.getKey("q"): me.takeoff()

    if KP.getKey("p"): sys.exit()

    return [lr, fb, ud, yv]

# me.streamon()
while True:
    # img = me.get_frame_read().frame
    # img = cv2.resize(img, (360, 240))
    # cv2.imshow("Image", img)
    # cv2.waitKey(1)

    params_from_Flutter()
    # vals = get_keyboard_input(0,1,2,3)
    # me.send_rc_control(vals[0], vals[1], vals[2], vals[3])
    sleep(0.05)
