import 'package:aerogotchi/screen/dronecontrolscreen.dart';
import 'package:aerogotchi/screen/foodmenuscreen.dart';
import 'package:flutter/material.dart';
import 'playingmenuscreen.dart'; // Import PlayingMenuScreen
import 'package:aerogotchi/screen/statusmenuscreen.dart';

class TempScreen extends StatefulWidget {
  const TempScreen({Key? key}) : super(key: key);

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
              title: 'Playing Menu',
              onPressed: () {
                // Navigate to PlayingMenuScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlayingMenuScreen()),
                );
              },
            ),
            MenuButton(
              title: 'Food Menu',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FoodMenuScreen()),
                );
              },
            ),
            MenuButton(
              title: 'Status Menu',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StatusMenuScreen()),
                );
              },
            ),
            MenuButton(
              title: 'Drone Control Menu',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DroneControlScreen()),
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
