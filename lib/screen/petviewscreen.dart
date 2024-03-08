import 'dart:async';
import 'package:aerogotchi/components/petview/buildBottomActionBox.dart';
import 'package:aerogotchi/components/petview/buildPetImageBox.dart';
import 'package:aerogotchi/components/petview/buildActionTopBox.dart';
import 'package:flutter/material.dart';
import 'package:aerogotchi/components/levels/happiness_level_service.dart';
import 'package:aerogotchi/components/levels/hunger_level_service.dart';
import 'package:aerogotchi/components/levels/hunger_level_timer.dart';
import 'package:aerogotchi/components/levels/happiness_level_timer.dart';
import 'package:aerogotchi/components/neglect_service.dart';
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            padding: const EdgeInsets.only(top: 100.0),
            child: const Center(
              child: Text(
                'PETVIEW',
                style: TextStyle(
                  color: Color(0xFFAC90FF),
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Color(0xFF4660E8),
                      offset: Offset(0, 8),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout_sharp),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(
                            petName: widget.petName,
                          )),
                );
              },
            ),
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue[800]!,
                  Colors.blue[400]!,
                ],
              ),
            ),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FoodMenuScreen()),
                            );
                          },
                          onPlayingMenuPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PlayingMenuScreen()),
                            );
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
