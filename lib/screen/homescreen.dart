import 'package:aerogotchi/reusable_widget/background_gradient.dart';
import 'package:aerogotchi/reusable_widget/custom_app_bar.dart';
import 'package:aerogotchi/screen/loginscreen.dart';
import 'package:aerogotchi/screen/petviewscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart'; // Import Firebase Realtime Database

class HomeScreen extends StatefulWidget {
  final String petName;
  const HomeScreen({Key? key, required this.petName}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'SIGN OUT',),
      extendBodyBehindAppBar: true, // Extend body behind app bar

      body: Container(
         decoration: BackgroundGradient.blueGradient,
        child: Center(
         
          child: ElevatedButton(
            child: Text("Sign Out"),
            onPressed: () {
              _showLogoutConfirmationDialog(context, widget.petName); // Pass petName to the dialog
            },
          ),
        ),
      ),
    );
  }

  // Function to show the logout confirmation dialog
  void _showLogoutConfirmationDialog(BuildContext context, String petName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Logout"),
          content: Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _logoutAndNavigateToLogin(context, petName); // Pass petName to the logout function
              },
              child: Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  // Function to logout and navigate to login screen
  void _logoutAndNavigateToLogin(BuildContext context, String petName) {
    FirebaseAuth.instance.signOut().then((value) {
      print("Signed Out");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
      // Pass petName to the PetViewScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PetViewScreen(petName: petName)),
      );
    });
  }
}
