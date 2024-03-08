import 'package:aerogotchi/screen/dronecontrolscreen.dart';
import 'package:aerogotchi/screen/settingscreen.dart';
import 'package:aerogotchi/screen/statusmenuscreen.dart';
import 'package:flutter/material.dart';

Container buildActionTopBox(
    BuildContext context, double screenWidth, String petName) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFF1F426F),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: const Color(0xFF18235B),
        width: 3.0,
      ),
    ),
    padding: const EdgeInsets.symmetric(vertical: 0),
    width: screenWidth,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildCircularButton(
            'assets/icons/droneIcon.png', const Color(0xFF929EC4), () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DroneControlScreen(
                      petName: petName,
                    )),
          );
        }, 90), // Change icon size here
        buildCircularButton(
            'assets/icons/statusIcon.png', const Color(0xFF00FF0A), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const StatusMenuScreen()),
          );
        }, 90), // Change icon size here
        buildCircularButton(
            'assets/icons/gearIcon.png', const Color(0xFF6354ED), () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SettingScreen(petName: petName)),
          );
        }, 90), // Change icon size here
      ],
    ),
  );
}

Widget buildCircularButton(
    String assetPath, Color color, VoidCallback onPressed, double iconSize) {
  return IconButton(
    icon: Image.asset(assetPath, width: iconSize, height: iconSize),
    onPressed: onPressed,
    color: color,
  );
}
