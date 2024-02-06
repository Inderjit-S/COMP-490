import 'package:aerogotchi/screen/settingscreen.dart';
import 'package:flutter/material.dart';
import 'package:aerogotchi/screen/dronecontrolscreen.dart';
import 'package:aerogotchi/screen/foodmenuscreen.dart';
import 'playingmenuscreen.dart'; // Import PlayingMenuScreen
import 'package:aerogotchi/screen/statusmenuscreen.dart';

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
        preferredSize: Size.fromHeight(130.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            padding: const EdgeInsets.only(top: 20.0),
            child: Center(
              child: Text(
                'PET VIEW',
                style: TextStyle(
                  color: Color(0xFFAC90FF),
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Color(0xFF4660E8),
                      offset: Offset(0, 8),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
            ),
          ),
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
                SizedBox(height: 0),
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => SettingScreen()),
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
      height: 200,
      alignment: Alignment.center,
      child: Text(
        'Pet Image',
        style: TextStyle(fontSize: 20),
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
