import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:aerogotchi/components/drone/custom_joystick.dart';
import 'package:aerogotchi/components/navigation_helper.dart';
import 'package:aerogotchi/screen/temphomescreen.dart';

class DroneControlScreen extends StatefulWidget {
  final String petName;

  const DroneControlScreen({Key? key, required this.petName}) : super(key: key);

  @override
  _DroneControlScreenState createState() => _DroneControlScreenState();
}

class _DroneControlScreenState extends State<DroneControlScreen> {
  @override
  void initState() {
    super.initState();
    // Lock the orientation to landscape mode
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.landscapeRight,
    // ]);
  }

  @override
  void dispose() {
    // Reset preferred orientation when disposing the screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  void callback(x, y) {
    log('callback x => $x and y $y');
  }

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
        child: Stack(
          children: [
            LandscapeDroneControlMenu(
              petName: widget.petName,
              callback: callback,
              onHomePressed: () {
                navigateToPetViewScreen(context, widget.petName);
              },
              onCameraPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Center(
                      child: Text('Image Captured!'),
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LandscapeDroneControlMenu extends StatelessWidget {
  final String petName;
  final Function callback;
  final Function onHomePressed;
  final Function onCameraPressed;

  LandscapeDroneControlMenu({
    required this.petName,
    required this.callback,
    required this.onHomePressed,
    required this.onCameraPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 20,
          bottom: 20,
          child: CustomJoystick(
            radius: 50.0,
            stickRadius: 10,
            callback: callback,
          ),
        ),
        Positioned(
          right: 20,
          bottom: 20,
          child: CustomJoystick(
            radius: 50.0,
            stickRadius: 10,
            callback: callback,
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
                SizedBox(width: 7),
                IconButton(
                  onPressed: () {
                    onCameraPressed();
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
