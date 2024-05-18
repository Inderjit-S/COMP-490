import 'package:aerogotchi/components/levels/happiness_level_service.dart';
import 'package:aerogotchi/components/levels/hunger_level_service.dart';
import 'package:aerogotchi/components/levels/level_service.dart';
import 'package:aerogotchi/reusable_widget/background_gradient.dart';
import 'package:aerogotchi/reusable_widget/custom_foodmenu_circular_button.dart';
import 'package:aerogotchi/reusable_widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart'; 

class FoodMenuScreen extends StatefulWidget {
  const FoodMenuScreen({super.key});

  @override
  _FoodMenuScreenState createState() => _FoodMenuScreenState();
}

class _FoodMenuScreenState extends State<FoodMenuScreen> {
  int? selectedButtonIndex;

  // Retrieve the Energy,Happiness,Hunger name from the database
  final dbRefEnergy =
      FirebaseDatabase.instance.reference().child('energy_level');
  final dbRefHappiness =
      FirebaseDatabase.instance.reference().child('happiness_level');
  final dbRefHunger =
      FirebaseDatabase.instance.reference().child('hunger_level');

  @override
  void initState() {
    super.initState();
    // Fetch initial levels
    LevelFetchService.fetchHungerLevel((value) {
      setState(() {
        
      });
    });
    LevelFetchService.fetchHappinessLevel((value) {
      setState(() {
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar(titleText: 'FOOD MENU', fontSize: 40, topPadding: 80),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BackgroundGradient.blueGradient,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                20.0, 0, 20.0, 20.0), 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Please select a food from the menu below',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color.fromRGBO(113, 172, 255, 1),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF9CAAFA),
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: const Color(0xFF18235B), width: 4),
                  ),
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    padding: const EdgeInsets.all(10),
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: <Widget>[
                      CircularButton(
                        imagePath: 'assets/icons/hamIcon.png',
                        isSelected: selectedButtonIndex == 0,
                        onPressed: () async {
                          setState(() {
                            selectedButtonIndex = 0;
                          });
                          final currentHungerLevel = await dbRefHunger
                              .once()
                              .then((event) => event.snapshot.value as int?);
                          //hunger
                          if (currentHungerLevel != null) {
                            if (currentHungerLevel == 10) {
                              //prevents overflow
                              await dbRefHunger.set(
                                  currentHungerLevel); //updates hunger level when clicked once
                            } else {
                              await dbRefHunger.set(currentHungerLevel +
                                  2); //updates hunger level when clicked once
                            }
                          }
                        },
                      ),
                      CircularButton(
                        imagePath: 'assets/icons/carrotIcon.png',
                        isSelected: selectedButtonIndex == 1,
                        onPressed: () async {
                          setState(() {
                            selectedButtonIndex = 1;
                          });

                          // Update hunger level
                          try {
                            await HungerLevelService.tryUpdateHungerLevel(1);
                          } catch (e) {
                            print('Error updating hunger level: $e');
                          }

                          // Update happiness level
                          try {
                            await HappinessLevelService.tryUpdateHappinessLevel(1);
                          } catch (e) {
                            print('Error updating happiness level: $e');
                          }
                        },
                      ),
                      CircularButton(
                        imagePath: 'assets/icons/icecreamIcon.png',
                        isSelected: selectedButtonIndex == 2,
                        onPressed: () async {
                          setState(() {
                            selectedButtonIndex = 2;
                          });
                          await HungerLevelService.tryUpdateHungerLevel(
                              1); // Increase hunger level 
                          await HappinessLevelService.tryUpdateHappinessLevel(
                              3); // Update happiness level
                        },
                      ),
                      CircularButton(
                        imagePath: 'assets/icons/breadIcon.png',
                        isSelected: selectedButtonIndex == 3,
                        onPressed: () async {
                          setState(() {
                            selectedButtonIndex = 3;
                          });
                          await HungerLevelService.tryUpdateHungerLevel(
                              2); // Increase hunger level 
                          await HappinessLevelService.tryUpdateHappinessLevel(
                              1); // Update happiness level
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


