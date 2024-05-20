import 'package:aerogotchi/screen/dronecontrolscreen.dart';
import 'package:aerogotchi/screen/foodmenuscreen.dart';
import 'package:aerogotchi/screen/logoutscreen.dart';
import 'package:aerogotchi/screen/idlescreen.dart';
import 'package:aerogotchi/screen/petnamescreen.dart';
import 'package:aerogotchi/screen/petviewscreen.dart';
import 'package:aerogotchi/screen/playingmenuscreen.dart';
import 'package:aerogotchi/screen/settingscreen.dart';
import 'package:aerogotchi/screen/statusmenuscreen.dart';
import 'package:aerogotchi/screen/aerofacesscreen.dart';
import 'package:flutter/material.dart';

void navigateToIdleScreen(BuildContext context)
{
  Navigator.push(context, MaterialPageRoute(builder: (context)=> IdleScreen()));
}

void navigateToPetNameScreen(BuildContext context, String petName) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => PetNameScreen(petName: petName)),
  );
}

void navigateToPetViewScreen(BuildContext context, String petName) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => PetViewScreen(petName: petName)),
  );
}

void navigateToSettingScreen(BuildContext context,String petName){
  Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SettingScreen(petName: petName)),
          );
}
void navigateToFoodMenuScreen(BuildContext context){
  Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FoodMenuScreen()),
          );
}
void navigateToPlayingMenuScreen(BuildContext context){
  Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PlayingMenuScreen()),
          );
}
void navigateToStatusMenuScreen(BuildContext context){
  Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StatusMenuScreen()),
          );
}
void navigateToAeroFacesScreen(BuildContext context){
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => AeroFacesScreen()),
  );
}
void navigateToDroneControlScreen(BuildContext context,String petName){
  Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DroneControlScreen(petName: petName)),
          );
}
void navigateToLogoutScreen(BuildContext context,String petName){
  Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LogoutScreen(petName: petName)),
          );
}