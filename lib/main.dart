import 'package:aerogotchi/screen/homescreen.dart';
import 'package:aerogotchi/screen/idlescreen.dart';
import 'package:aerogotchi/screen/loginscreen.dart';
import 'package:aerogotchi/screen/petnamescreen.dart';
import 'package:aerogotchi/screen/petviewscreen.dart';
import 'package:aerogotchi/screen/playingmenuscreen.dart';
import 'package:aerogotchi/screen/foodmenuscreen.dart';
import 'package:aerogotchi/screen/settingscreen.dart';
import 'package:aerogotchi/screen/temphomescreen.dart';
import 'package:aerogotchi/screen/statusmenuscreen.dart';
import 'package:aerogotchi/screen/dronecontrolscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   try {
//     await Firebase.initializeApp();
//   } catch (e) {
//     print('Error initializing Firebase: $e');
//   }
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        primarySwatch: Colors.blue,
      ),
      // home: const PetViewScreen(),
      // home: const TempScreen(), // Temp screen to test shit out
      home: const PetNameScreen(),
    );
  }
}
