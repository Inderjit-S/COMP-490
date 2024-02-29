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
interval = 0.25
dInterval = fSpeed * interval
aInterval = aSpeed * interval

# Screen and Initial Box Dimensions
screenWidth, screenHeight = 1000, 1000
initialBoxSize = 200  # Initial size of the box, can be adjusted

# Initialization
x, y = 500, 500  # Drone's initial position
a = 0
yaw = 0
kp.init()
me = tello.Tello()
me.connect()
print(me.get_battery())

# Function to handle keyboard input and adjust drone movement
def getKeyboardInput():
    lr, fb, ud, yv = 0, 0, 0, 0
    speed = 15
    aspeed = 50
    global x, y, yaw, a
    d = 0

    # Movement keys
    if kp.getKey("LEFT"):
        lr = -speed
        d = dInterval
        a = -180
    elif kp.getKey("RIGHT"):
        lr = speed
        d = -dInterval
        a = 180

    if kp.getKey("UP"):
        fb = speed
        d = dInterval
        a = 270
    elif kp.getKey("DOWN"):
        fb = -speed
        d = -dInterval
        a = -90

    if kp.getKey("w"):
        ud = speed
    elif kp.getKey("s"):
        ud = -speed

    if kp.getKey("a"):
        yv = -aspeed
        yaw -= aInterval
    elif kp.getKey("d"):
        yv = aspeed
        yaw += aInterval

    if kp.getKey("q"): me.land(); sleep(3)
    if kp.getKey("e"): me.takeoff()
    if kp.getKey("p"): sys.exit()

    sleep(interval)
    a += yaw

    # Update drone position based on input
    x += int(d * math.cos(math.radians(a)))
    y += int(d * math.sin(math.radians(a)))

    return [lr, fb, ud, yv]

# Function to draw the dynamic box based on drone's position
def drawDynamicBox(img, x, y, screenWidth, screenHeight, initialBoxSize):
    # Calculate proximity to edges
    proximity = min(x, y, screenWidth - x, screenHeight - y)
    
    # Adjust box size based on proximity
    boxSize = max(initialBoxSize, initialBoxSize + (200 - proximity) * 2)
    boxSize = min(boxSize, screenWidth / 2, screenHeight / 2)  # Ensure box is not larger than screen
    
    # Calculate box coordinates
    topLeft = (int(x - boxSize / 2), int(y - boxSize / 2))
    bottomRight = (int(x + boxSize / 2), int(y + boxSize / 2))
    
    # Draw the box
    cv2.rectangle(img, topLeft, bottomRight, (255, 0, 0), 2)  # Blue box with thickness of 2

while True:
    vals = getKeyboardInput()
    me.send_rc_control(vals[0], vals[1], vals[2], vals[3])

    # Initialize a black image
    img = np.zeros((screenHeight, screenWidth, 3), np.uint8)

    # Draw the dynamic box based on the drone's current position
    drawDynamicBox(img, x, y, screenWidth, screenHeight, initialBoxSize)

    # Display the result
    cv2.imshow("Output", img)
    if cv2.waitKey(1) & 0xFF == ord('q'):  # Exit on pressing 'q'
        break

cv2.destroyAllWindows()

