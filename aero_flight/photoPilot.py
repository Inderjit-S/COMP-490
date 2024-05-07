from djitellopy import tello
import cv2
import numpy as np
import time

telloInstance = tello.Tello()
telloInstance.connect()
bat = print(telloInstance.get_battery())

w = 360
h = 240

while True:
    img = telloInstance.get_frame_read().frame # read frame
    resize = cv2.resize(img, (w,h))
    
    cv2.imshow("Output", img) # create output window
    if cv2.waitKey(1) & 0xFF == ord('s'): # press S for picture
        cv2.imwrite("test.jpg", resize)
        print("Picture Taken")
    if cv2.waitKey(1) & 0xFF == ord('q'):
        telloInstance.land()
        break