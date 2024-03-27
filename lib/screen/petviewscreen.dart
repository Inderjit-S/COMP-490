import 'dart:async';
import 'package:aerogotchi/components/navigation_helper.dart';
import 'package:aerogotchi/components/petview/buildBottomActionBox.dart';
import 'package:aerogotchi/components/petview/buildPetImageBox.dart';
import 'package:aerogotchi/components/petview/buildActionTopBox.dart';
import 'package:aerogotchi/reusable_widget/background_gradient.dart';
import 'package:aerogotchi/reusable_widget/custom_petview_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:aerogotchi/components/levels/happiness_level_service.dart';
import 'package:aerogotchi/components/levels/hunger_level_service.dart';
import 'package:aerogotchi/components/timers/hunger_level_timer.dart';
import 'package:aerogotchi/components/timers/happiness_level_timer.dart';
import 'package:aerogotchi/components/timers/neglect_service_timer.dart';
import 'package:aerogotchi/screen/homescreen.dart';
import 'package:aerogotchi/screen/foodmenuscreen.dart';
import 'package:aerogotchi/screen/playingmenuscreen.dart';

class PetViewScreen extends StatefulWidget {
  final String petName;
  const PetViewScreen({Key? key, required this.petName}) : super(key: key);

  @override
  _PetViewScreenState createState() => _PetViewScreenState();
}

class _PetViewScreenState extends State<PetViewScreen> {
  int hungerLevel = 0;
  int happinessLevel = 0;
  int neglectTimerSeconds = 0; // Variable to store the neglect timer value

  late HungerLevelTimer _hungerLevelTimer;
  late HappinessLevelTimer _happinessLevelTimer;
  late Timer _neglectTimer;

  @override
  void initState() {
    super.initState();
    HungerLevelService.getHungerLevel().then((value) {
      setState(() {
        hungerLevel = value;
      });
      _startHungerTimer();
    }).catchError((error) {
      print('Error fetching hunger level: $error');
    });
    HappinessLevelService.getHappinessLevel().then((value) {
      setState(() {
        happinessLevel = value;
      });
      _startHappinessTimer();
    }).catchError((error) {
      print('Error fetching happiness level: $error');
    });
    NeglectService.startInactivityTimer();
    //Neglect timer for display
    _neglectTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        neglectTimerSeconds =
            NeglectService.inactivityDuration.inSeconds - timer.tick;
      });
    });
  }

  void _startHungerTimer() {
    _hungerLevelTimer = HungerLevelTimer(updateHungerLevel: (level) {
      setState(() {
        hungerLevel = level;
      });
      HungerLevelService.updateHungerLevel(hungerLevel).catchError((error) {
        print('Error updating hunger level: $error');
      });
    });
    _hungerLevelTimer.startTimer(hungerLevel);
  }

  void _startHappinessTimer() {
    _happinessLevelTimer = HappinessLevelTimer(updateHappinessLevel: (level) {
      setState(() {
        happinessLevel = level;
      });
      HappinessLevelService.updateHappinessLevel(happinessLevel)
          .catchError((error) {
        print('Error updating happiness level: $error');
      });
    });
    _happinessLevelTimer.startTimer(happinessLevel);
  }

  @override
  void dispose() {
    _hungerLevelTimer.cancelTimer();
    _happinessLevelTimer.cancelTimer();
    _neglectTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    NeglectService.onUserActivity();

    return Scaffold(
      appBar: CustomPetViewAppBar(
        titleText: 'PETVIEW',
        petName: '',
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BackgroundGradient.blueGradient,
          ),
          Positioned.fill(
            top: MediaQuery.of(context).padding.top + 80,
            child: Column(
              children: [
                const SizedBox(height: 30),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildActionTopBox(
                            context, screenWidth * 0.8, widget.petName),
                        const SizedBox(height: 20),
                        buildPetImageBox(
                          petName: widget.petName,
                          hungerLevel: hungerLevel,
                          happinessLevel: happinessLevel,
                          neglectTimerSeconds: neglectTimerSeconds,
                          width: screenWidth * 0.80,
                        ),
                        const SizedBox(height: 20),
                        BottomActionBox(
                          width: screenWidth * 0.7,
                          onFoodMenuPressed: () {
                          navigateToFoodMenuScreen(context);
                          },
                          onPlayingMenuPressed: () {
                           navigateToPlayingMenuScreen(context);
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCircularButton(
      String assetPath, Color color, VoidCallback onPressed, double iconSize) {
    return IconButton(
      icon: Image.asset(assetPath, width: iconSize, height: iconSize),
      onPressed: onPressed,
      color: color,
    );
  }
}
