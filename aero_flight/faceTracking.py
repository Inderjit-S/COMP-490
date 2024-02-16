from djitellopy import tello
import cv2
import numpy as np
import time


tello = tello.Tello()
tello.connect()
print(tello.get_battery())

tello.streamon()
tello.takeoff()
#time.sleep(1)
tello.send_rc_control(0,0,10,0)
time.sleep(0.2)

w, h = 360, 240
fbRange = [6200, 6800]
pid = [0.4, 0.4, 0] # research what pid is
pError = 0

def findFace(img):
    #faceCascadeName = cv2.data.haarcascades + 'haarcascadefrontalface_alt.xml'
    faceCascadeName = cv2.data.haarcascades + 'haarcascade_frontalface_default.xml'
    faceCascade = cv2.CascadeClassifier()
    if not faceCascade.load(cv2.samples.findFile(faceCascadeName)):
        print("Error loading xml file")
        exit(0)
    # this finds the haarcascade_frontalface_alt.xml file without us having to download it. Maybe look into alternative way?

    imgGray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    faces = faceCascade.detectMultiScale(imgGray, 1.2, 8)

    myFaceList = [] # making list of faces and follow the biggest one, aka, the closest one
    myFaceListArea = [] # area value

    for (x,y,w,h) in faces:
        cv2.rectangle(img, (x, y), (x+w, y+h), (0,0,255), 2) #created rectangle and passed image, cords, color, and thickness
        center_x = x + w//2
        center_y = y + h//2
        area = w*h
        myFaceList.append([center_x,center_y])
        myFaceListArea.append(area)
        cv2.circle(img, (center_x, center_y), 5,  (0,255,0), cv2.FILLED) #adds filled green circle in center of image
        myFaceList.append([center_x, center_y])
        myFaceListArea.append(area)
    if len(myFaceListArea) != 0:
        i = myFaceListArea.index(max(myFaceListArea))
        return img, [myFaceList[i], myFaceListArea[i]]
    else:
        return img, [[0,0],0]


def tracking(info, w, pid, pError):
    area = info[1]
    x,y = info[0]
    fb = 0

    error = x - w//2
    speed = pid[0] * error + pid[1] * (error-pError)
    speed = int(np.clip(speed, -100, 100))

    area = info[1]
    if area > fbRange[0] and area < fbRange[1]:
        fb = 0 # stationary when in "green zone"
    elif area > fbRange[1]: # first index so 6800
        fb = fb - 20 # too close so move back
    elif area < fbRange[0] and area != 0: # 0th index so 6200
        fb = 20

    if x == 0:
        speed = 0
        error = 0

    #print(speed, fb)

    tello.send_rc_control(0, fb, 0, speed)
    return error

#cap = cv2.VideoCapture(0) # videocapture from webcam
while True:
    #_, img = cap.read() # for webcams
    img = tello.get_frame_read().frame
    img = cv2.resize(img, (w,h))
    img, info = findFace(img)
    pError = tracking(info, w, pid, pError)
    #print("Center", info[0], "Area", info[1])
    cv2.imshow("Output", img)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        tello.land()
        break