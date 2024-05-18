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
initialBoxSize = 200  # Initial size of the box, can be adjusted

# Initialization
x, y = 500, 500  # Drone's initial position (not used for position in this visualization)
a = 0
yaw = 0
kp.init()
me = tello.Tello()
me.connect()
print(me.get_battery())

def getKeyboardInput():
    lr, fb, ud, yv = 0, 0, 0, 0
    speed = 45  # Increased speed
    aspeed = 50
    global x, y, yaw, a

    if kp.getKey("LEFT"): lr = -speed
    if kp.getKey("RIGHT"): lr = speed
    if kp.getKey("UP"): fb = speed
    if kp.getKey("DOWN"): fb = -speed
    if kp.getKey("w"): ud = speed
    if kp.getKey("s"): ud = -speed
    if kp.getKey("a"): yv = -aspeed
    if kp.getKey("d"): yv = aspeed
    if kp.getKey("q"): me.land(); sleep(3)
    if kp.getKey("e"): me.takeoff()
    if kp.getKey("p"): sys.exit()

    return [lr, fb, ud, yv]

def drawDynamicBoxWithDroneDot(img, screenWidth, screenHeight, initialBoxSize):
    # Center the box on the screen and dynamically adjust size
    centerX, centerY = screenWidth // 2, screenHeight // 2
    
    # Calculate the new size of the box based on drone's movements if needed
    boxSize = initialBoxSize
    
    # Calculate top-left and bottom-right corners of the box
    topLeftCorner = (centerX - boxSize // 2, centerY - boxSize // 2)
    bottomRightCorner = (centerX + boxSize // 2, centerY + boxSize // 2)
    
    # Draw rectangle (box)
    cv2.rectangle(img, topLeftCorner, bottomRightCorner, (255, 0, 0), 2)
    
    # Keep the drone (dot) at the center of the screen
    cv2.circle(img, (centerX, centerY), 10, (0, 255, 0), -1)

while True:
    vals = getKeyboardInput()
    me.send_rc_control(vals[0], vals[1], vals[2], vals[3])
    img = np.zeros((screenHeight, screenWidth, 3), np.uint8)
    drawDynamicBoxWithDroneDot(img, screenWidth, screenHeight, initialBoxSize)
    cv2.imshow("Output", img)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cv2.destroyAllWindows()

