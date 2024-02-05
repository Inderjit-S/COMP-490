import 'package:flutter/material.dart';
import 'package:aerogotchi/screen/temphomescreen.dart';

class DroneControlScreen extends StatefulWidget {
  @override
  _DroneControlScreenState createState() => _DroneControlScreenState();
}

class _DroneControlScreenState extends State<DroneControlScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drone Control', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: LandscapeDroneControlMenu(
        onHomePressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TempScreen()),
          );
        },
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
              border: Border.all(color: Colors.black),
            ),
            child: Center(
              child: Text('Joystick 1'),
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
              border: Border.all(color: Colors.black),
            ),
            child: Center(
              child: Text('Joystick 2'),
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
                    child: Icon(Icons.home, color: Colors.grey),
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
                    child: Icon(Icons.camera_alt, color: Colors.grey),
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
