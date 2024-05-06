from djitellopy import tello
import cv2
import numpy as np
import time

telloInstance = tello.Tello()
telloInstance.connect()
print(telloInstance.get_battery())

