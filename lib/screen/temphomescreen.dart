import 'package:aerogotchi/screen/dronecontrolscreen.dart';
import 'package:aerogotchi/screen/foodmenuscreen.dart';
import 'package:aerogotchi/screen/idlescreen.dart';
import 'package:aerogotchi/screen/loginscreen.dart';
import 'package:aerogotchi/screen/petviewscreen.dart';
import 'package:aerogotchi/screen/signupscreen.dart';
import 'package:flutter/material.dart';
import 'playingmenuscreen.dart'; // Import PlayingMenuScreen
import 'package:aerogotchi/screen/statusmenuscreen.dart';
import 'package:firebase_database/firebase_database.dart'; // Import Firebase Realtime Database

class TempScreen extends StatefulWidget {
  final String petName;
  const TempScreen({Key? key, required this.petName}) : super(key: key);

  @override
  _TempScreenState createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temporary Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MenuButton(
              title: 'Petview',
              onPressed: () {
                // Navigate to PlayingMenuScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PetViewScreen(petName: widget.petName,)),
                );
              },
            ),
            MenuButton(
              title: 'idle',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => IdleScreen()),
                );
              },
            ),
            MenuButton(
              title: 'Signup',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
            ),
            MenuButton(
              title: 'log in',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
            MenuButton(
              title: 'Option 3',
              onPressed: () {
                // Add navigation or functionality for Option 3
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const MenuButton({
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
