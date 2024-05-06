from djitellopy import tello
import KeyPressModule as kp
import numpy as np
from time import sleep
import cv2
import math
import sys

# PARAMETERS
fSpeed = 117 / 10  # Forward Speed in cm/s (11.7cm/s)
aSpeed = 360 / 10  # Angular Speed Degrees/s (36°/s)

# Screen and Initial Box Dimensions
screenWidth, screenHeight = 1000, 1000
initialBoxSize = 400  # Initial size of the box, can be adjusted

# Initialization
x, y = 500, 500  # Drone's initial position
a = 0
yaw = 0
kp.init()

# NPC Vars
dir = 1
start_pos_x = 500
start_pos_y = 500
random = [0,0]
mode = "auto"  # Initial mode
mode_check = False

def getKeyboardInput():
    lr, fb, ud, yv = 0, 0, 0, 0
    speed = 45  # Increased speed
    aspeed = 50
    global x, y, yaw, a, mode, mode_check

    # Switch mode
    if kp.getKey("m") and not mode_check:
        mode_check = True
        if mode == "keyboard":
            mode = "auto"
            print("Switched to auto mode")
        else:
            mode = "keyboard"
            print("Switched to keyboard mode")
    if kp.getKey("m") and mode_check: mode_check = False


    if mode == "keyboard":
        if kp.getKey("LEFT"): lr = -speed; x -= 1
        if kp.getKey("RIGHT"): lr = speed; x += 1
        if kp.getKey("UP"): fb = speed; y -= 1
        if kp.getKey("DOWN"): fb = -speed; y += 1
        if kp.getKey("w"): ud = speed
        if kp.getKey("s"): ud = -speed
        if kp.getKey("a"): yv = -aspeed
        if kp.getKey("d"): yv = aSpeed

    if kp.getKey("p"): sys.exit()

    return [lr, fb, ud, yv, x, y]

def change_state(arr):
    x = np.random.choice(arr)
    return x

def process_change(x):
    global dir, random
    DJIDirX, DJIDirY = 0,0
    movement_decision = np.random.default_rng().integers(low=0, high=100, size=1)

    if movement_decision >= 0 and movement_decision <=2: 
        print("new dir")
        random = np.random.default_rng().integers(low=-50, high=50, size=2)
        print(f'Random: {random[0]}')
        dir = change_state([1,2,3,4])
    elif movement_decision > 2 and movement_decision <=70: print('don"t move')
    else:
        print("move")
        DJIDirX, DJIDirY = process_move(dir, random)
    
    return [DJIDirX, DJIDirY]

def process_move(a, arr):
    global x, y
    speed = 1

    # x: -movement is towards the left and +movement is towards the right
    # y: -movement is towards the top and +movement is towards the bottom
    x_travel = (start_pos_x+arr[0])-x
    y_travel = (start_pos_y+arr[1])-y
    
    # Updates X coordinate
    if abs(x_travel) < speed: x = x
    elif x_travel < 0: 
        x -= speed
        if x <= start_pos_x - 50: x = start_pos_x - 49
    elif x_travel > 0: 
        x += speed
        if x >= start_pos_x + 50: x = start_pos_x + 49
    
    # Updates Y coordinate
    if abs(y_travel) < speed: y = y
    elif y_travel < 0: 
        y -= speed
        if y <= start_pos_y - 50: y = start_pos_y - 49
    elif y_travel > 0: 
        y += speed
        if y >= start_pos_y + 50: y = start_pos_y + 49

def drawDynamicBoxWithDroneDot(img, x, y, screenWidth, screenHeight, initialBoxSize):
    # mappingv2 box
    topLeft = (screenWidth // 2 - initialBoxSize // 2, screenHeight // 2 - initialBoxSize // 2)
    bottomRight = (screenWidth // 2 + initialBoxSize // 2, screenHeight // 2 + initialBoxSize // 2)
    cv2.rectangle(img, topLeft, bottomRight, (255, 0, 0), 2)

    # Drone as a dot
    cv2.circle(img, (x, y), 10, (0, 255, 0), -1)
    if mode == "auto": cv2.circle(img, (10,10), 10, (0, 255, 0), -1)

while True:
    vals = getKeyboardInput()
    if mode=="auto": val2 = process_change(change_state([1,2,3,4,5,6,7,8,9,10]))
    # me.send_rc_control(vals[0], vals[1], vals[2], vals[3])
    img = np.zeros((screenHeight, screenWidth, 3), np.uint8)
    drawDynamicBoxWithDroneDot(img, x, y, screenWidth, screenHeight, initialBoxSize)  # Updated function call
    cv2.imshow("Output", img)
    print(x,y)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cv2.destroyAllWindows()
