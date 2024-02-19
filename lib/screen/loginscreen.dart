import 'package:aerogotchi/screen/homescreen.dart';
import 'package:aerogotchi/screen/petviewscreen.dart';
import 'package:aerogotchi/screen/signupscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../reusable_widget/reusable_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _passwordTextController =
      TextEditingController(); //enable password entry
  TextEditingController _emailTextController =
      TextEditingController(); //enable email entry
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xFF2A5EE1), //change bg color (top)
                Color(0xFF1F48D0), //change bg color (main)
                Color(0xFF2A5EE1)
              ], //change bg color (bottom)
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(
                height: 0, // Adjusted height to create less space
              ),
              Container(
                width: MediaQuery.of(context).size.width *
                    1, // Adjust the width as needed
                height: MediaQuery.of(context).size.width *
                    1, // Adjust the height as needed
                child: logoWidget(
                    "background_image/aerogotchi.png"), //image file path for logo
              ),
              SizedBox(
                height: 0, // Adjusted height to create less space
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width *
                    0.8, // Adjust the width as needed
                height: 50, // Adjust the height as needed
                child: reusableTextField("Enter Email", Icons.person_outline,
                    false, _emailTextController), //open text field for email
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width *
                    0.8, // Adjust the width as needed
                height: 50, // Adjust the height as needed
                child: reusableTextField(
                    "Enter Password",
                    Icons.lock_outline,
                    true,
                    _passwordTextController), //open text field for password
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 79,
                child: signInButton(context, true, () async {
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text);

                    // Retrieve the pet name from the database
                    final dbRef = FirebaseDatabase.instance.reference().child('petname');
                    DatabaseEvent event = await dbRef.once();
                    String petName = event.snapshot.value.toString();

                    // Pass the pet name to the PetViewScreen
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PetViewScreen(petName: petName)));
                  } on FirebaseAuthException catch (e) {
                    print("Error: ${e.toString()}");
                  }; //enable sign in button to show up
                }),
              ),
              signUpOption() //enable signUpOption
            ],
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    //SignUp Option Function
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text("Don't have account?",
          style: GoogleFonts.varelaRound(color: Colors.white70)),
      GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SignUpScreen())); //routes to SignUpScreen when pressed
          },
          child: Text(
            "  Sign Up",
            style: GoogleFonts.varelaRound(
                color: Colors.white, fontWeight: FontWeight.bold),
          ))
    ]);
  }
}
