import 'package:aerogotchi/components/navigation_helper.dart';
import 'package:flutter/material.dart';
import 'package:aerogotchi/screen/temphomescreen.dart';
import 'package:firebase_database/firebase_database.dart'; // Import Firebase Realtime Database

class DroneControlScreen extends StatefulWidget {
  final String petName;
  const DroneControlScreen({Key? key, required this.petName}) : super(key: key);
  @override
  _DroneControlScreenState createState() => _DroneControlScreenState();
}

class _DroneControlScreenState extends State<DroneControlScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Drone Control', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.black,
        child: LandscapeDroneControlMenu(
          onHomePressed: () {
            navigateToPetViewScreen(context, widget.petName);
          },
        ),
      ),
    );
  }
}

class LandscapeDroneControlMenu extends StatelessWidget {
  final Function onHomePressed;

  LandscapeDroneControlMenu({required this.onHomePressed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 20,
          bottom: 20,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white),
            ),
            child: Center(
              child: Text(
                'Joystick 1',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        Positioned(
          right: 20,
          bottom: 20,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white),
            ),
            child: Center(
              child: Text(
                'Joystick 2',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    onHomePressed();
                  },
                  icon: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey.withOpacity(0.5),
                    child: Icon(Icons.home, color: Colors.white),
                  ),
                ),
                SizedBox(width: 20),
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Center(
                          // Center the text
                          child: Text('Image Captured!'),
                        ),
                        backgroundColor: Colors.transparent, // Clear background
                      ),
                    );
                  },
                  icon: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey.withOpacity(0.5),
                    child: Icon(Icons.camera_alt, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
