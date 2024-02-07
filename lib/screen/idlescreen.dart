import 'dart:async';
import 'package:aerogotchi/reusable_widget/reusable_widget.dart';
import 'package:aerogotchi/screen/loginscreen.dart';
import 'package:flutter/material.dart';

class IdleScreen extends StatefulWidget {
  const IdleScreen({Key? key}) : super(key: key);

  @override
  _IdleScreenState createState() => _IdleScreenState();
}

class _IdleScreenState extends State<IdleScreen> {
  bool isTextVisible = true;

  @override
  void initState() {
    super.initState();

    // Set up a timer to toggle text visibility every 800 milliseconds (adjust as needed)
    Timer.periodic(Duration(milliseconds: 800), (timer) {
      setState(() {
        isTextVisible = !isTextVisible;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF2A5EE1), //change bg color (top)
              Color(0xFF1F48D0), //change bg color (main)
              Color(0xFF2A5EE1), //change bg color (bottom)
            ],
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: MediaQuery.of(context).size.height *
                  0.30, // Adjust as needed CHANGES LOGO HEIGHT
              left: 0,
              right: 0,
              child: Center(
                child: Transform.scale(
                  scale: 1.1, // Adjust as needed
                  child: logoWidget("background_image/aerogotchi.png"),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height *
                  .850, // Adjust as needed CHANGES MESSAGE HEIGHT
              left: 0,
              right: 0,
              child: Center(
                child: Visibility(
                  visible: isTextVisible,
                  child: Text(
                    "Tap to continue",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      decoration: TextDecoration.none,
                      color: Color(0xFF95B2F8),
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.5), // Shadow color
                          offset:
                              Offset(0, 2), // Shadow position, x and y offset
                          blurRadius: 3, // Shadow blur radius
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
