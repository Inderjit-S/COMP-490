import 'package:aerogotchi/screen/petviewscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
              logoWidget("background_image/aerogotchi.png"), //image file path for logo
              Text(
                'SETTINGS',
                style: GoogleFonts.varelaRound(
                  color: Color(0xFFAC90FF),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 250,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(147, 0, 0, 0), // Color of the outline BARS
                    width: 2, // Thickness of the outline
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    'Restart',
                    style: TextStyle(
                      color: Color(0xFFAC90FF),
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 250,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(147, 0, 0, 0),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PetViewScreen()));
                  },
                  child: Center(
                    child: Text(
                      'Back',
                      style: TextStyle(
                        color: Color(0xFFAC90FF),
                        fontWeight: FontWeight.bold ,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
