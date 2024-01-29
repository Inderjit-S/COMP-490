import 'package:aerogotchi/reusable_widget/reusable_widget.dart';
import 'package:flutter/material.dart';

import 'homescreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super (key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text(
        "Sign Up",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ),
      body: Container(width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height ,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0xFFA4A0A0),
          Color(0xFF8E9393),
          Color(0xFFA4A0A0)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Email", Icons.person_outline, false, _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outline, true, _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                signInButton((context), false, (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                })
              ],
            )
        )
      ),)
    );
  }
}
