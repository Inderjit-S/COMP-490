from djitellopy import tello
import cv2
import numpy as np
import time
import KeyPressModule as KP
import sys
import random
import faceTracking, skyShuffle, photoPilot, firebaseListener

def get_keyboard_input(aerogotchi):
    global face_tracking_flag, photo_pilot_flag, sky_shuffle_flag
    lr, fb, ud, yv = 0, 0, 0, 0
    speed = 50
    if KP.getKey("LEFT"): lr = -speed
    elif KP.getKey("RIGHT"): lr = speed

    if KP.getKey("UP"): fb = speed
    elif KP.getKey("DOWN"): fb = -speed

    if KP.getKey("w"): ud = speed
    elif KP.getKey("s"): ud = -speed

    if KP.getKey("a"): yv = speed
    elif KP.getKey("d"): yv = -speed

    # Commented for apt testing purposes
    # Needs to uncomment for proper flight test
    if KP.getKey("e"): aerogotchi.land()
    if KP.getKey("q"): aerogotchi.takeoff()

    # Key Presses for separate drone functions
    # "1": photoPilot function (take a photo from drone camera)
    # "2": skyShuffle function (does random dance choreography)
    flag = firebaseListener.firebase_listener()
    if flag == "1":
        photo_pilot_flag = True
        print("Photo Pilot enabled")
    if flag == "2":
        sky_shuffle_flag = True
        print('Sky Shuffle enabled')
    if flag == "3":
        face_tracking_flag = not face_tracking_flag
        if face_tracking_flag: print("Face Tracking Enabled")
        else: 
            print("Face Tracking Disabled")
            firebaseListener.firebase_resetter()
            aerogotchi.send_rc_control(0, 0, 0, 0)

    if KP.getKey("p"): sys.exit()

    return [lr, fb, ud, yv]

def main():
    KP.init()
    aerogotchi = tello.Tello()
    aerogotchi.connect()
    aerogotchi.streamon()

    # Face Tracking Necessary Info
    w, h = 360, 240
    # fbRange = [6200, 6800]

    pid = [0.3, 0.4, 0]
    pError = 0

    # Sky Shuffle
    # Photo Pilot

    global face_tracking_flag, photo_pilot_flag, sky_shuffle_flag
    face_tracking_flag, photo_pilot_flag, sky_shuffle_flag = False, False, False

    while True:
        img = aerogotchi.get_frame_read().frame # read frame
        img = cv2.resize(img, (w,h))
        firebaseListener.firebase_listener()

        if face_tracking_flag: 
            img, info = faceTracking.findFace(img)
            pError = faceTracking.tracking(aerogotchi, info, w, h, pid, pError)

        if photo_pilot_flag:
            pic = photoPilot.takePhoto(img, w, h)
            cv2.imshow("Output", pic)
            time.sleep(5)
            photo_pilot_flag = False
            print("Photo Pilot disabled")
            firebaseListener.firebase_resetter()

        if sky_shuffle_flag:
            if aerogotchi.get_battery() < 50: 
                sky_shuffle_flag = False
                print('Not enough battery for Sky Shuffle')
            else:
                random_func = random.choice([skyShuffle.danceOne, skyShuffle.danceTwo, skyShuffle.danceThree])
                random_func(aerogotchi)
                sky_shuffle_flag = False
                print("Sky Shuffle disabled")
            firebaseListener.firebase_resetter()

        img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
        cv2.imshow("Output", img) # create output window

        vals = get_keyboard_input(aerogotchi)
        if not face_tracking_flag and not sky_shuffle_flag: aerogotchi.send_rc_control(vals[0], vals[1], vals[2], vals[3])
        time.sleep(0.05)
        print(aerogotchi.get_current_state())

    # draw something on the output picture and change variable names.

if __name__ == '__main__':
    main()