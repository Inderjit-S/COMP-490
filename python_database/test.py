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
    db.reference("/").update({tello.get_battery})
    data = ref.get()
    print(data)
    sleep(5) # update firebase database every 5 seconds. Increase later

# # Update Energy Level Method 2
# while True:
#     battery = tello.get_battery
#     ref.update({'battery': battery})
#     sleep(5) # update firebase database every 5 seconds. Increase later


# Manual update for energy level
# db.reference("/").update({"energy_level": 5})
# data = ref.get()

# print(data)  # Print the retrieved data
