import 'package:aerogotchi/screen/petviewscreen.dart';
import 'package:flutter/material.dart';
import '../reusable_widget/reusable_widget.dart';
import 'package:firebase_database/firebase_database.dart'; // Import Firebase Realtime Database

class PetNameScreen extends StatefulWidget {
  const PetNameScreen({Key? key}) : super(key: key);

  @override
  State<PetNameScreen> createState() => _PetNameScreen();
}

class _PetNameScreen extends State<PetNameScreen> {
  TextEditingController characterNameController = TextEditingController();

  // Reference to 'petname' node in the database
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child('petname');

  void savePetName(String petName) {
    databaseReference.set(petName); // Set the pet name in the database
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Adjust these variables for container width and height
    double containerWidth = screenWidth * 0.75;
    double containerHeight = screenHeight * 0.2;

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Colors.blue[700], // Set app bar background to transparent
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue[800]!,
              Colors.blue[400]!,
            ],
          ),
        ),
        child: Center(
          child: Transform.scale(
            scale: 1.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmallerlogoWidget("background_image/aerogotchi.png"),
                Text(
                  'NAME MENU',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6354ED), // Set font color
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Customize your drone',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 172, 195, 248).withOpacity(0.75),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Pick a name:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6354ED),
                  ),
                ),
                Container(
                  width: containerWidth,
                  height: containerHeight,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      reusableTextField(
                        "e.g. Sparky, AeroBot, SkyDancer",
                        Icons.pets_outlined,
                        false,
                        characterNameController,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          String petName = characterNameController.text;
                          if (petName.isNotEmpty) {
                            savePetName(
                                petName); // Save the pet name to the database
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PetViewScreen()),
                            );
                          } else {
                            // Show error message if pet name is empty
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Please enter a pet name')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF92B1F6),
                          onPrimary: Color.fromARGB(255, 123, 91, 229),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                            side: BorderSide(
                              color: Color(0xFF1C205E),
                              width: 3,
                            ),
                          ),
                        ),
                        child: Text(
                          'Save Pet Name & Continue',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
