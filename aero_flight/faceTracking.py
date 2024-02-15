import cv2
import numpy as np

def findFace(img):
    faceCascadeName = cv2.data.haarcascades + 'haarcascadefrontalface_alt.xml'
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

cap = cv2.VideoCapture(0) # videocapture from webcam

while True:
    _, img = cap.read()
    findFace(img)
    cv2.imshow("Output", img)
    cv2.waitKey(1)