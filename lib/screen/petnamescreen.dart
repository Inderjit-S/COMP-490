import 'package:aerogotchi/components/navigation_helper.dart';
import 'package:aerogotchi/reusable_widget/background_gradient.dart';
import 'package:aerogotchi/reusable_widget/custom_app_bar.dart';
import 'package:aerogotchi/screen/petviewscreen.dart';
import 'package:flutter/material.dart';
import '../reusable_widget/reusable_widget.dart';
import 'package:firebase_database/firebase_database.dart'; // Import Firebase Realtime Database

class PetNameScreen extends StatefulWidget {
  final String? petName;
  const PetNameScreen({Key? key, this.petName}) : super(key: key);

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
    String petName =
        widget.petName ?? ''; //return widget.petName if not null and '' if null
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Adjust these variables for container width and height
    double containerWidth = screenWidth * 0.75;
    double containerHeight = screenHeight * 0.2;

    return Scaffold(
      appBar: CustomAppBar(titleText: ' ',),
      extendBodyBehindAppBar: true, // Extend body behind app bar
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BackgroundGradient.blueGradient,
        child: Center(
          child: Transform.scale(
            scale: 1.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmallerlogoWidget("background_image/aerogotchi.png"), //image url
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
                      reusableTextField( //Field to enter data
                        "e.g. Sparky, AeroBot, SkyDancer",
                        Icons.pets_outlined,
                        false,
                        characterNameController,
                      ),
                      ElevatedButton(
                        onPressed: () { //Validate petname is not empty when pressed and navigate to PetviewScreen upon success
                          String petName = characterNameController.text;
                          if (petName.isNotEmpty) {
                            savePetName(
                                petName); // Save the pet name to the database
                            navigateToPetViewScreen(context, petName);
                          } else {
                            // Show error message if pet name is empty
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Please enter a pet name')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                        //  primary: Color(0xFF92B1F6),
                          //onPrimary: Color.fromARGB(255, 123, 91, 229),
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
