from djitellopy import tello
import cv2
import numpy as np
import time

def takePhoto(img, w, h):
    test = cv2.imwrite("test.jpg", img)
    print("Picture Taken")
    test = cv2.resize(test, (w,h))
    return test

if __name__ == '__main__':
    telloInstance = tello.Tello()
    telloInstance.connect()
    bat = print(telloInstance.get_battery())
    telloInstance.streamon()

    w = 360
    h = 240

    while True:
        img = telloInstance.get_frame_read().frame # read frame
        img = cv2.resize(img, (w,h))
        
        cv2.imshow("Output", img) # create output window
        if cv2.waitKey(1) & 0xFF == ord('s'): # press S for picture
            # test = cv2.imwrite("test.jpg", img)
            # print("Picture Taken")
            # test = cv2.resize(test, (w,h))
            test = takePhoto(img, w, h)
            cv2.imshow("Output", test)
            time.sleep(5)
        if cv2.waitKey(1) & 0xFF == ord('q'):
            telloInstance.land()
            break

    # draw something on the output picture and change variable names.