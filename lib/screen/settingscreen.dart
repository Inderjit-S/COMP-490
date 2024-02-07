import 'package:aerogotchi/screen/petviewscreen.dart';
import 'package:flutter/material.dart';
import '../reusable_widget/reusable_widget.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingsState();
}

class _SettingsState extends State<SettingScreen> {
  TextEditingController restartController = TextEditingController();
  TextEditingController backController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Adjust these variables for container width and height
    double containerWidth = screenWidth * 0.6;
    double containerHeight = screenHeight * 0.2;

    return Scaffold(
      body: Container(
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              logoWidget(
                  "background_image/aerogotchi.png"), //image file path for logo
              Text(
                'SETTINGS',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6354ED), // Set font color
                ),
              ),
              SizedBox(height: 20),
              // Adjust width and height of the container
              Container(
                width: containerWidth,
                height: containerHeight,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFF6354ED),
                  borderRadius: BorderRadius.circular(35),
                  border: Border.all(
                    color: Color(0xFF1C205E), // Stroke color for the container
                    width: 3,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF2D7ADE),
                        onPrimary: Color(0xFFA990FF),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                          side: BorderSide(
                            color: Color(0xFF1C205E),
                            width: 3,
                          ),
                        ),
                      ),
                      child: Text(
                        'Restart',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PetViewScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF92B1F6),
                        onPrimary: Color.fromARGB(255, 123, 91, 229),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                          side: BorderSide(
                            color: Color(0xFF1C205E),
                            width: 3,
                          ),
                        ),
                      ),
                      child: Text(
                        'Back',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
