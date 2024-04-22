import 'package:aerogotchi/components/navigation_helper.dart';
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
    // Adjust width to fit the content without overflowing
    width: screenWidth, 
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // Wrap children with Expanded to evenly distribute space
      children: [
        Expanded(
          child: buildCircularButton(
            'assets/icons/droneIcon.png', const Color(0xFF929EC4), () {
              navigateToDroneControlScreen(context, petName);
            },
            90,
          ),
        ),
        Expanded(
          child: buildCircularButton(
            'assets/icons/statusIcon.png', const Color(0xFF00FF0A), () {
              navigateToStatusMenuScreen(context);
            },
            90,
          ),
        ),
        Expanded(
          child: buildCircularButton(
            'assets/icons/gearIcon.png', const Color(0xFF6354ED), () {
              navigateToSettingScreen(context, petName);
            },
            90,
          ),
        ),
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
