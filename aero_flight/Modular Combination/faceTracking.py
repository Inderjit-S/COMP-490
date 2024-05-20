from djitellopy import tello
import cv2
import numpy as np
import time

fbRange = [6200, 6800]

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


def tracking(telloDrone, info, w, h, pid, pError):
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
    telloDrone.send_rc_control(0, fb, -speed_ud, speed)
    return error

if __name__ == '__main__':
    # connection to the drone
    telloDrone = tello.Tello()
    telloDrone.connect()

    print(telloDrone.get_battery()) # print battery for information

    telloDrone.streamon() # turns on video streaming
    telloDrone.takeoff()

    # Drone flys up for 3.5 seconds
    telloDrone.send_rc_control(0,0,20,0)
    time.sleep(3.5)

    w, h = 360, 240
    fbRange = [6200, 6800]

    pid = [0.3, 0.4, 0] # Proportional-Integral-Derivative. The P determines the responsiveness and agressiveness.
    # The I can make the controller slugglish and less smooth. Using both, you can affect how smooth the drone flies and recieves commands.

    pError = 0

    while True:
        img = telloDrone.get_frame_read().frame # read frame
        img = cv2.resize(img, (w,h))
        # linking functions together
        img, info = findFace(img)
        pError = tracking(info, w, h, pid, pError)
        
        cv2.imshow("Output", img) # create output window
        if cv2.waitKey(1) & 0xFF == ord('q'): # keeps frames displaying constantly
            telloDrone.land()
            break