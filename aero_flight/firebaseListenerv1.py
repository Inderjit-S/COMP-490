# Scripts combined so far (before flight test)
# 1: keyboardControlv1.py
# 2: photoPilot.py
# 3: skyShuffle.py
# 4: faceTracking.py

from djitellopy import tello
import firebase_admin
from firebase_admin import db, credentials
import cv2
import numpy as np
import time
import KeyPressModule as KP
import sys
import random
# from skyShuffle import danceOne, danceTwo, danceThree
# import firebaseListenerv2 as FL

KP.init()
flight = False

cred = credentials.Certificate("python_database\\cred.json")
firebase_admin.initialize_app(cred, {"databaseURL": "https://aerogotchi-signin-default-rtdb.firebaseio.com/"})

def firebase_listener():
    ref = db.reference('/')
    data = ref.get()
    print(data)
    # time.sleep(5)
    # sys.exit()

def get_keyboard_input(telloInstance, img, w, h, pid, pError):
    global isTracking
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

    # Commented for apt testing purposes
    # Needs to uncomment for proper flight test
    # if KP.getKey("e") and flight:
    #     telloInstance.land()
    # if KP.getKey("q") and not flight:
    #     telloInstance.takeoff()

    # Key Presses for separate drone functions
    # "1": photoPilot function (take a photo from drone camera)
    # "2": skyShuffle function (does random dance choreography)
    if KP.getKey("1"):
        take_picture(img, w, h)
    if KP.getKey("2") and flight:
        random_function = random.choice([danceOne, danceTwo, danceThree])
        random_function(telloInstance)
    if KP.getKey("3"):
        isTracking = not isTracking
        if isTracking: print("Face Tracking Enabled")
        else: 
            print("Face Tracking Disabled")
            telloInstance.send_rc_control(0, 0, 0, 0)
    # if KP.getKey("4"):
    #     firebase_listener()

    if KP.getKey("p"):
        sys.exit()

    return [lr, fb, ud, yv]

def take_picture(img, w, h):
    test = cv2.imwrite("test.jpg", img)
    print("Picture Taken")
    test = cv2.resize(test, (w,h))
    cv2.imshow("Output", test)
    time.sleep(5)

def danceOne(telloInstance):
    print("1")
    telloInstance.flip_right()
    time.sleep(2)
    telloInstance.flip_left()
    time.sleep(2)
    telloInstance.flip_back()
    time.sleep(2)
    telloInstance.land()

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
    telloInstance.land()

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
    telloInstance.land()

def findFace(img):
    # pass in face recognition file
    faceCascadeName = cv2.data.haarcascades + 'haarcascade_frontalface_default.xml'
    faceCascade = cv2.CascadeClassifier()
    if not faceCascade.load(cv2.samples.findFile(faceCascadeName)):
        print("Error loading xml file")
        exit(0)
    # this finds the haarcascade_frontalface_alt.xml file without us having to download it

    imgGray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    faces = faceCascade.detectMultiScale(imgGray, 1.2, 8)

    myFaceList = [] # making list of faces and follow the biggest one, aka, the closest one
    myFaceListArea = [] # area value


    for (x,y,w,h) in faces:
        cv2.rectangle(img, (x, y), (x+w, y+h), (0,0,255), 2) # created rectangle and passed image, cords, color, and thickness
        center_x = x + w//2 # The center of the screen horizontally
        center_y = y + h//2 # The center of the screen vertically
        area = w*h
        myFaceList.append([center_x,center_y]) # appends center coordinates
        myFaceListArea.append(area)
        cv2.circle(img, (center_x, center_y), 5,  (0,255,0), cv2.FILLED) # adds filled green circle in center of image (a small dot)
        myFaceList.append([center_x, center_y])
        myFaceListArea.append(area)
    if len(myFaceListArea) != 0:
        i = myFaceListArea.index(max(myFaceListArea)) # find the index of the largest area
        return img, [myFaceList[i], myFaceListArea[i]] # return the coordinates
    else:
        return img, [[0,0],0] # No face was found, return default


def tracking(telloInstance, info, w, h, pid, pError):
    area = info[1]
    x,y = info[0]
    fb = 0 # used for front/back

    # PID for left/right
    error = x - w//2
    speed = pid[0] * error + pid[1] * (error-pError)
    speed = int(np.clip(speed, -100, 100))

    # PID for up/down
    error_ud = y - h//2
    speed_ud = pid[0] * error_ud + pid[1] * (error_ud-pError)
    speed_ud = int(np.clip(speed_ud, -100, 100))

    # moving front/back algorithm. If it's true close, move back, if too far, move forward. If distance is just right, remain stationary
    area = info[1]
    if area > fbRange[0] and area < fbRange[1]:
        fb = 0 # stationary when in "green zone"
    elif area > fbRange[1]: # first index so 6800
        fb = fb - 20 # too close so move back
    elif area < fbRange[0] and area != 0: # 0th index so 6200
        fb = 20

    # If drone is centered on x value, keep the speed 0
    if x == 0:
        speed = 0
        error = 0

    # if drone is centered on y value, keep the up/down speed 0
    if y == 0:
        speed_ud = 0

    # send in values for moving the drone. (left/right, front/back, up/down, yaw velocity)
    telloInstance.send_rc_control(0, fb, -speed_ud, speed)
    return error

def main():
    telloInstance = tello.Tello()
    telloInstance.connect()
    bat = print(telloInstance.get_battery())
    telloInstance.streamon()

    w = 360
    h = 240
    
    global fbRange
    fbRange = [6200, 6800]

    pid = [0.3, 0.4, 0]
    pError = 0

    global isTracking
    isTracking = False

    while True:
        img = telloInstance.get_frame_read().frame # read frame
        img = cv2.resize(img, (w,h))
        
        if isTracking: 
            img, info = findFace(img)
            pError = tracking(telloInstance, info, w, h, pid, pError)

        img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
        cv2.imshow("Output", img) # create output window
        if cv2.waitKey(1) & 0xFF == ord('s'): # press S for picture
            take_picture(img, w, h)
        if cv2.waitKey(1) & 0xFF == ord('q'):
            telloInstance.land()
            break

        vals = get_keyboard_input(telloInstance, img, w, h, pid, pError)
        telloInstance.send_rc_control(vals[0], vals[1], vals[2], vals[3])
        time.sleep(0.05)

        firebase_listener()
        # FL.firebase_listener()

    # draw something on the output picture and change variable names.

if __name__ == '__main__':
    main()