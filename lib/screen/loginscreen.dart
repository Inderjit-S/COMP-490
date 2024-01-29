import 'package:aerogotchi/screen/signupscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../reusable_widget/reusable_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key:key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _passwordTextController = TextEditingController(); //enable password entry
  TextEditingController _emailTextController = TextEditingController(); //enable email entry
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFF2A5EE1), //change bg color (top)
            Color(0xFF1F48D0), //change bg color (main)
            Color(0xFF2A5EE1)], //change bg color (bottom)
          begin: Alignment.topCenter, end: Alignment.bottomCenter),),
      child:  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            logoWidget("background_image/aerogotchi.png"), //image file path for logo
              SizedBox(
                height:10,
              ),
              reusableTextField("Enter Email", Icons.person_outline, false, _emailTextController), //open text field for email
              SizedBox(
                height:10,
              ),
          reusableTextField("Enter Password", Icons.lock_outline, true, _passwordTextController), //open text field for password
              SizedBox(
                height: 20,
              ),
              signInButton(context,true, () {}), //enable sign in button to show up
              signUpOption() //enable signUpOption
        ],
              ),
              ),
          ),
        );
  }
  Row signUpOption (){ //SignUp Option Function
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Text("Don't have account?",
        style: GoogleFonts.varelaRound(color: Colors.white70)),
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen())); //routes to SignUpScreen when pressed
          },
          child: Text(
            "  Sign Up",
            style: GoogleFonts.varelaRound(color: Colors.white,fontWeight: FontWeight.bold),
          )
        )
      ]
    );
  }
}
