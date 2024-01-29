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

    // Set up a timer to toggle text visibility every 500 milliseconds (adjust as needed)
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        isTextVisible = !isTextVisible;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            logoWidget("background_image/aerogotchi.png"),
            SizedBox(
              height: 240,
            ),
            Visibility(
              visible: isTextVisible,
              child: Text(
                "Tap to continue",
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.white60,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
