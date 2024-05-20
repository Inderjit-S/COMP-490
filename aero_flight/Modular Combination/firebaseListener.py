from djitellopy import tello
import firebase_admin
from firebase_admin import db, credentials
import numpy as np

cred = credentials.Certificate("491\Combined Scripts\cred.json")
firebase_admin.initialize_app(cred, {"databaseURL": "https://aerogotchi-signin-default-rtdb.firebaseio.com/"})
db.reference("/").update({"event" : 'manual'})

curr_event = 'manual'

def firebase_listener():
    ref = db.reference('/')
    data = ref.get()
    if data['event'] != curr_event:
        match data['event']:
            case 'Sky-Shuffle':
                # skyShuffle()
                return '2'
            case 'Follow the Leader':
                # faceTracking()
                return '3'
            case 'Photo Pilot':
                # photoPilot()
                return '1'

def firebase_resetter():
    db.reference("/").update({"event" : 'manual'})

def skyShuffle():
    print('skyShuffle')
    db.reference("/").update({"event" : 'manual'})

def faceTracking():
    print('faceTracking')

def photoPilot():
    print('photoPilot')


if __name__ == '__main__':
    while True:
        print('Starting Firebase Listener')
        firebase_listener()
