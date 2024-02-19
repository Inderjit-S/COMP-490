import 'package:aerogotchi/screen/petnamescreen.dart';
import 'package:flutter/material.dart';
import 'package:aerogotchi/reusable_widget/reusable_widget.dart';
import 'package:aerogotchi/screen/homescreen.dart';
import 'package:aerogotchi/screen/dronecontrolscreen.dart';
import 'package:aerogotchi/screen/foodmenuscreen.dart';
import 'package:aerogotchi/screen/playingmenuscreen.dart';
import 'package:aerogotchi/screen/statusmenuscreen.dart';
import 'package:aerogotchi/screen/settingscreen.dart';
import 'package:firebase_database/firebase_database.dart'; // Import Firebase Realtime Database

class PetViewScreen extends StatefulWidget {
  final String petName;
  const PetViewScreen({Key? key, required this.petName}) : super(key: key);

  @override
  _PetViewScreenState createState() => _PetViewScreenState();
}

class _PetViewScreenState extends State<PetViewScreen> {

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            padding: const EdgeInsets.only(top: 100.0),
            child: const Center(
              child: Text(
                'PETVIEW',
                style: TextStyle(
                  color: Color(0xFFAC90FF),
                  fontSize: 35.0,
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
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout_sharp),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  HomeScreen(petName: widget.petName,)),
                );
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
                const SizedBox(height: 30),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildActionTopBox(width: screenWidth * 0.8),
                        const SizedBox(height: 20),
                        buildPetImageBox(width: screenWidth * 0.80),
                        const SizedBox(height: 20),
                        buildBottomActionBox(width: screenWidth * 0.7),
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
        color: const Color(0xFF1F426F),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF18235B),
          width: 3.0,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 0),
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildCircularButton(
              'assets/icons/droneIcon.png', const Color(0xFF929EC4), () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DroneControlScreen(petName: widget.petName,)),
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
                  builder: (context) =>  SettingScreen(petName: widget.petName)),
            );
          }, 90), // Change icon size here
        ],
      ),
    );
  }

  Container buildPetImageBox({required double width}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF666D8C),
        borderRadius: BorderRadius.circular(46),
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      width: width,
      height: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SmallerlogoWidget("background_image/aerogotchi.png"),
          const SizedBox(height: 5),
           Text(
           '${widget.petName}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
            ),
          ),
        ],
      ),
    );
  }

  Container buildBottomActionBox({required double width}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF6354ED),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF18235B),
          width: 2.0,
        ),
      ),
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildCircularButton(
              'assets/icons/bluehamIcon.png', const Color(0xFF5EBBFF), () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FoodMenuScreen()),
            );
          }, 100), // Change icon size here
          buildCircularButton(
              'assets/icons/gameIcon.png', const Color(0xFFF692B0), () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PlayingMenuScreen()),
            );
          }, 100), // Change icon size here
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
}
