import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../reusable_widget/reusable_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key:key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFFA4A0A0),
            Color(0xFF8E9393),
            Color(0xFFA4A0A0)],
          begin: Alignment.topCenter, end: Alignment.bottomCenter),),
      child:  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            logoWidget("background_image/aerogotchi.png"),
              SizedBox(
                height:10,
              ),
              reusableTextField("Enter UserName", Icons.person_outline, false, _emailTextController),
              SizedBox(
                height:10,
              ),
          reusableTextField("Enter Password", Icons.lock_outline, true, _passwordTextController),
              SizedBox(
                height: 20,
              ),
              signInButton(context,true, () {})
        ],
              ),
              ),
          ),
        );
  }
}
