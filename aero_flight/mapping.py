from djitellopy import tello
import KeyPressModule as kp
import numpy as np
from time import sleep
import cv2
import math
import sys

# PARAMETERS
# Speed is now a constant value for drone commands that specify distance; adjustment for dynamic speed is not directly supported by the SDK commands.
# Angular speed adjustments will be handled by rotation commands (cw, ccw) instead of a constant speed.
interval = 0.25  # Reviewing the need for this interval since it contributes to the perceived delay.

# Screen and Initial Box Dimensions
screenWidth, screenHeight = 1000, 1000
initialBoxSize = 200  # Static box size

# Initialization
x, y = 500, 500  # Drone's initial position on the screen, not using SDK's position data
a = 0  # This angle is for visualization, not drone control
yaw = 0  # For visualization
kp.init()
me = tello.Tello()
me.connect()
print(me.get_battery())

# Function to handle keyboard input and adjust drone movement using specific distance commands
def getKeyboardInput():
    lr, fb, ud, yv = 0, 0, 0, 0
    d = 20  # Minimum movement distance in cm
    global x, y, yaw, a

    if kp.getKey("LEFT"): me.send_rc_control(0, 0, 0, -30); sleep(0.1); me.left(d)
    if kp.getKey("RIGHT"): me.send_rc_control(0, 0, 0, 30); sleep(0.1); me.right(d)
    if kp.getKey("UP"): me.send_rc_control(0, 30, 0, 0); sleep(0.1); me.forward(d)
    if kp.getKey("DOWN"): me.send_rc_control(0, -30, 0, 0); sleep(0.1); me.back(d)
    if kp.getKey("w"): me.up(d)
    if kp.getKey("s"): me.down(d)
    if kp.getKey("a"): me.ccw(45)  # Rotate counterclockwise
    if kp.getKey("d"): me.cw(45)  # Rotate clockwise
    if kp.getKey("q"): me.land(); sleep(3)
    if kp.getKey("e"): me.takeoff()
    if kp.getKey("p"): sys.exit()

    # Adjustments to visualization, not actual drone control
    # Removed the movement calculations since we're now using distance commands directly
    return [lr, fb, ud, yv]

# Modified to draw a static box and represent the drone as a moving dot within it
def drawStaticBoxAndDrone(img, x, y, screenWidth, screenHeight, initialBoxSize):
    # Static box in the center of the screen
    boxTopLeft = (int(screenWidth / 2 - initialBoxSize / 2), int(screenHeight / 2 - initialBoxSize / 2))
    boxBottomRight = (int(screenWidth / 2 + initialBoxSize / 2), int(screenHeight / 2 + initialBoxSize / 2))
    cv2.rectangle(img, boxTopLeft, boxBottomRight, (255, 0, 0), 2)  # Blue box with thickness of 2

    # Represent the drone as a dot on the screen
    cv2.circle(img, (x, y), 10, (0, 255, 0), -1)  # Green dot for the drone

while True:
    vals = getKeyboardInput()

    # Initialize a black image
    img = np.zeros((screenHeight, screenWidth, 3), np.uint8)

    # Draw the static box and represent the drone's position as a dot
    drawStaticBoxAndDrone(img, x, y, screenWidth, screenHeight, initialBoxSize)

    # Display the result
    cv2.imshow("Output", img)
    if cv2.waitKey(1) & 0xFF == ord('q'):  # Exit on pressing 'q'
        break

cv2.destroyAllWindows()