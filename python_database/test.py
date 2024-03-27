import firebase_admin
from djitellopy import Tello
from firebase_admin import db, credentials
from time import sleep

# connect drone
tello = Tello()
tello.connect()

# Initialize Firebase app with provided credentials
cred = credentials.Certificate("python_database\\cred.json")
firebase_admin.initialize_app(cred, {"databaseURL": "https://aerogotchi-signin-default-rtdb.firebaseio.com/"})

# Get a reference to the root node of the database
ref = db.reference("/")
data = ref.get()
print(data)  # Print the retrieved data

# Update Energy Level Method 1
while True:
    db.reference("/").update({"energy_level" : tello.get_battery()})
    data = ref.get()
    print(data)
    sleep(5) # Change to however long we want it to update


# Manual update for energy level
# db.reference("/").update({"energy_level": 3})
# data = ref.get()

# print(data)  # Print the retrieved data
