import 'package:aerogotchi/reusable_widget/reusable_widget.dart';
import 'package:aerogotchi/screen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:aerogotchi/screen/dronecontrolscreen.dart';
import 'package:aerogotchi/screen/foodmenuscreen.dart';
import 'playingmenuscreen.dart'; // Import PlayingMenuScreen
import 'package:aerogotchi/screen/statusmenuscreen.dart';
import 'package:aerogotchi/screen/settingscreen.dart';
import 'package:aerogotchi/screen/temphomescreen.dart';

class PetViewScreen extends StatefulWidget {
  const PetViewScreen({Key? key}) : super(key: key);

  @override
  _PetViewScreenState createState() => _PetViewScreenState();
}

class _PetViewScreenState extends State<PetViewScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0), // Set the preferred height
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            padding: const EdgeInsets.only(top: 60.0), // Adjust top padding
            child: Center(
              child: Text(
                'PETVIEW',
                style: TextStyle(
                  color: Color(0xFFAC90FF),
                  fontSize: 32.0, // Increased font size
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Color(0xFF4660E8),
                      offset: Offset(
                          0, 8), // Adjust the offset to create a lifting effect
                      blurRadius:
                          6, // Increase blur radius for a more prominent shadow
                    ),
                  ],
                ),
              ),
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              // LOGOUT BUTTON
              icon: Icon(Icons.logout_sharp),
              onPressed: () {
                //logout function from your authentication logic
                // Navigate back to the home screen
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
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
          ),
          Positioned.fill(
            top: MediaQuery.of(context).padding.top + 80,
            child: Column(
              children: [
                SizedBox(height: 10),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildActionTopBox(
                            width: screenWidth * 0.7), // 70% of screen width
                        SizedBox(
                            height:
                                20), //SPACE BETWEEN IMAGE AND BUTTON BOX : TOP
                        buildPetImageBox(width: screenWidth * 0.7), // Pet Image
                        SizedBox(
                            height:
                                20), //SPACE BETWEEN IMAGE AND BUTTON BOX : BOTTOM
                        buildBottomActionBox(
                            width: screenWidth * 0.6), // Adjust width
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildActionTopBox({required double width}) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF1F426F),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.black, // Black stroke
          width: 2.0, // Thicker border
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 10),
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildCircularButton(Icons.abc_rounded, Color(0xFF929EC4), () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DroneControlScreen()),
            );
          }),
          buildCircularButton(Icons.mood, Color(0xFF00FF0A), () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StatusMenuScreen()),
            );
          }),
          buildCircularButton(Icons.settings, Color(0xFF6354ED), () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingScreen()),
            );
          }),
        ],
      ),
    );
  }

  Container buildPetImageBox({required double width}) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF666D8C),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.black, // Black stroke
          width: 2.0, // Thicker border
        ),
      ),
      width: width,
      height: 250, // Increased height to accommodate text
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SmallerlogoWidget("background_image/aerogotchi.png"), // Image widget
          SizedBox(height: 5), // Spacer between image and text
          Text(
            'Character Name', // Add Character Name
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Container buildBottomActionBox({required double width}) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF6354ED),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.black, // Black stroke
          width: 2.0, // Thicker border
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 10),
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildCircularButton(Icons.fastfood, Color(0xFF5EBBFF), () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FoodMenuScreen()),
            );
          }),
          buildCircularButton(Icons.videogame_asset, Color(0xFFF692B0), () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PlayingMenuScreen()),
            );
          }),
        ],
      ),
    );
  }

  Widget buildCircularButton(
      IconData iconData, Color color, VoidCallback onPressed) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(
          color: Colors.black, // Black stroke
          width: 2.0, // Thicker border
        ),
      ),
      child: IconButton(
        icon: Icon(iconData),
        onPressed: onPressed,
        color: Colors.blue,
      ),
    );
  }
}
