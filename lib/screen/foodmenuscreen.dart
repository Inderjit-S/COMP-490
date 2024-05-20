import 'dart:developer';
import 'package:aerogotchi/components/levels/happiness_level_service.dart';
import 'package:aerogotchi/components/levels/hunger_level_service.dart';
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
  int personality = 0; 
  int ham_hunger_weight  = 0;
  int carrot_hunger_weight  = 0;
  int icecream_hunger_weight  = 0;
  int bread_hunger_weight  = 0;
  int ham_happiness_weight = 0;
  int carrot_happines_weight  = 0;
  int icecream_happiness_weight  = 0;
  int bread_happiness_weight  = 0;
      

  // Retrieve the Energy, Happiness, Hunger name from the database
  final dbRefper = FirebaseDatabase.instance.reference().child('personality');
  final dbRefEnergy = FirebaseDatabase.instance.reference().child('energy_level');
  final dbRefHappiness = FirebaseDatabase.instance.reference().child('happiness_level');
  final dbRefHunger = FirebaseDatabase.instance.reference().child('hunger_level');

  @override
  void initState() {
    super.initState();
    _initializePersonality();
  }

  void _initializePersonality() async {
    // Fetch personality from the database
    final personalitySnapshot = await dbRefper.once();
    setState(() {
      personality = personalitySnapshot.snapshot.value as int? ?? 0;
      getPersonality();
    });
  }

  void getPersonality() {
    switch (personality) {
      case 1:
        ham_hunger_weight  = 1;
        carrot_hunger_weight  = 2;
        icecream_hunger_weight  = 1;
        bread_hunger_weight  = 2;

        ham_happiness_weight = 1;
        carrot_happines_weight  = 2;
        icecream_happiness_weight  = 1;
        bread_happiness_weight  = 2;
      
        break;
      case 2:
        ham_hunger_weight  = 1;
        carrot_hunger_weight  = 2;
        icecream_hunger_weight  = 2;
        bread_hunger_weight  = 1;

        ham_happiness_weight = 1;
        carrot_happines_weight  = 2;
        icecream_happiness_weight  = 2;
        bread_happiness_weight  = 1;
        break;
      case 3:
        ham_hunger_weight  = 2;
        carrot_hunger_weight  = 1;
        icecream_hunger_weight  = 1;
        bread_hunger_weight  = 2;

        ham_happiness_weight = 2;
        carrot_happines_weight  = 1;
        icecream_happiness_weight  = 1;
        bread_happiness_weight  = 2;
        break;
      default:
        
    }
    log('Personality: $personality, Hunger Weights -> Ham: $ham_hunger_weight , Carrot: $carrot_hunger_weight , Ice Cream: $icecream_hunger_weight , Bread: $bread_hunger_weight ');
    log('Personality: $personality, Happiness Weights -> Ham: $ham_happiness_weight , Carrot: $carrot_happines_weight , Ice Cream: $icecream_happiness_weight , Bread: $bread_happiness_weight ');
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'FOOD MENU', fontSize: 40, topPadding: 80),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BackgroundGradient.blueGradient,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
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
                    border: Border.all(color: const Color(0xFF18235B), width: 4),
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
                          try {
                            await HungerLevelService.tryUpdateHungerLevel(ham_hunger_weight);
                            await HappinessLevelService.tryUpdateHappinessLevel(ham_happiness_weight); // Assuming some happiness increment
                          } catch (e) {
                            print('Error updating levels: $e');
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
                          // Update hunger and happiness level
                          try {
                            await HungerLevelService.tryUpdateHungerLevel(carrot_hunger_weight );
                            await HappinessLevelService.tryUpdateHappinessLevel(carrot_happines_weight);
                          } catch (e) {
                            print('Error updating levels: $e');
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
                          await HungerLevelService.tryUpdateHungerLevel(icecream_hunger_weight ); // Increase hunger level
                          await HappinessLevelService.tryUpdateHappinessLevel(icecream_happiness_weight); // Update happiness level
                        },
                      ),
                      CircularButton(
                        imagePath: 'assets/icons/breadIcon.png',
                        isSelected: selectedButtonIndex == 3,
                        onPressed: () async {
                          setState(() {
                            selectedButtonIndex = 3;
                          });
                          await HungerLevelService.tryUpdateHungerLevel(bread_hunger_weight ); // Increase hunger level
                          await HappinessLevelService.tryUpdateHappinessLevel(bread_happiness_weight); // Update happiness level
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
