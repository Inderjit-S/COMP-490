import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:aerogotchi/components/drone/custom_joystick.dart';
import 'package:aerogotchi/components/navigation_helper.dart';

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

  void callback(x, y, pos) async {
    String curr_movement = getJoystickSection(x, y, pos);
    String db_movement = '';
    if (pos == 'left') {
      db_movement = await JoystickService.getJoystickLeft();
    } else {
      db_movement = await JoystickService.getJoystickRight();
    }
    if (db_movement != curr_movement) {
      if (pos == 'left') {
        JoystickService.updateJoystickLeft(curr_movement);
      } else {
        JoystickService.updateJoystickRight(curr_movement);
      }
    }
    log('callback $pos => x $x and y $y and pos $curr_movement');
  }

  String getJoystickSection(x, y, z) {
    String joystickDirection = 'Origin';
    if (x == 0 && y == 0) {
      joystickDirection = 'Origin';
    } else if (x > 0 && y > -x && y < x) {
      if (z == 'left') {
        joystickDirection = 'Rotate R';
      } else {
        joystickDirection = 'Right';
      }
    } else if (x < 0 && y < -x && y > x) {
      if (z == 'left') {
        joystickDirection = 'Rotate L';
      } else {
        joystickDirection = 'Left';
      }
    } else if (y > 0 && y > x && y > -x) {
      if (z == 'left') {
        joystickDirection = 'Up';
      } else {
        joystickDirection = 'Forward';
      }
    } else if (y < 0 && y < x && y < -x) {
      if (z == 'left') {
        joystickDirection = 'Down';
      } else {
        joystickDirection = 'Backward';
      }
    }
    return joystickDirection;
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
              position: "Null",
            ),
          ],
        ),
      ),
    );
  }
}

class LandscapeDroneControlMenu extends StatelessWidget {
  final String petName;
  final String position;
  final Function callback;
  final Function onHomePressed;
  final Function onCameraPressed;

  LandscapeDroneControlMenu({
    required this.petName,
    required this.callback,
    required this.onHomePressed,
    required this.onCameraPressed,
    required this.position,
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
            position: "left",
          ),
        ),
        Positioned(
          right: 20,
          bottom: 20,
          child: CustomJoystick(
            radius: 50.0,
            stickRadius: 10,
            callback: callback,
            position: "right",
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
