import 'package:aerogotchi/screen/loginscreen.dart';
import 'package:aerogotchi/screen/petviewscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Logout"),
          onPressed: () {
            _showLogoutConfirmationDialog(context); // Show confirmation dialog
          },
        ),
      ),
    );
  }

  // Function to show the logout confirmation dialog
  void _showLogoutConfirmationDialog(BuildContext context) {
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
                // Navigate back to the PetViewScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => PetViewScreen()),
                );
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _logoutAndNavigateToLogin(
                    context); // Logout and navigate to login
              },
              child: Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  // Function to logout and navigate to login screen
  void _logoutAndNavigateToLogin(BuildContext context) {
    FirebaseAuth.instance.signOut().then((value) {
      print("Signed Out");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }
}
