import firebase_admin
from firebase_admin import db, credentials

# Initialize Firebase app with provided credentials
cred = credentials.Certificate("python_database\\cred.json")
firebase_admin.initialize_app(cred, {"databaseURL": "https://aerogotchi-signin-default-rtdb.firebaseio.com/"})

# Get a reference to the root node of the database
ref = db.reference("/")
data = ref.get()
print(data)  # Print the retrieved data

# Update Energy Level
 
db.reference("/").update({"energy_level": 5})
data = ref.get()

print(data)  # Print the retrieved data
