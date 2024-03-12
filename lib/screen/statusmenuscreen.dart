import 'package:aerogotchi/components/levels/level_service.dart';
import 'package:aerogotchi/reusable_widget/custom_status_bar.dart';
import 'package:aerogotchi/reusable_widget/background_gradient.dart';
import 'package:aerogotchi/reusable_widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

class StatusMenuScreen extends StatefulWidget {
  const StatusMenuScreen({Key? key});

  @override
  _StatusMenuScreenState createState() => _StatusMenuScreenState();
}

class _StatusMenuScreenState extends State<StatusMenuScreen> {
  int energyLevel = 0;
  int hungerLevel = 0;
  int happinessLevel = 0;

  @override
  void initState() {
    super.initState();
    initializeLevels();
  }

  void initializeLevels() {
    LevelFetchService.fetchEnergyLevel((value) {
      setState(() {
        energyLevel = value;
      });
    });
    LevelFetchService.fetchHungerLevel((value) {
      setState(() {
        hungerLevel = value;
      });
    });
    LevelFetchService.fetchHappinessLevel((value) {
      setState(() {
        happinessLevel = value;
      });
    });
  }

  // Functions to retrieve the Energy, Happiness, Hunger name from the database
  // *************************************

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'PET STATUS'),
      extendBodyBehindAppBar: true, // Extend body behind app bar
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BackgroundGradient.blueGradient,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StatusBar(
              icon: Icons.flash_on, // Lightning bolt icon
              label: 'Energy', // Energy status label
              level: energyLevel, // Energy level
              iconColor: Colors.yellow, // Yellow color for the icon
              circleColor: const Color.fromARGB(
                  147, 0, 0, 0), // Color of the outline BARS
              circleSize: 60, // ***CIRCLE*** Set circle size
            ),
            const SizedBox(height: 20), // Adjust the space between status bars
            StatusBar(
              icon: Icons.fastfood, // Burger icon
              label: 'Hunger', // Hunger status label
              level: hungerLevel, // Hunger level
              iconColor: Colors.blue[900]!, // Dark blue color for the icon
              circleColor: const Color.fromARGB(
                  147, 0, 0, 0), // Color of the outline BARS
              circleSize: 60, // ***CIRCLE*** Set circle size
            ),
            const SizedBox(height: 20), // Adjust the space between status bars
            StatusBar(
              icon: Icons.favorite, // Heart icon
              label: 'Happiness', // Happiness status label
              level: happinessLevel, // Happiness level
              iconColor: const Color.fromARGB(
                  255, 34, 237, 91), // Green color for the heart icon
              circleColor: const Color.fromARGB(
                  147, 0, 0, 0), // Color of the outline BARS
              circleSize: 60, // ***CIRCLE*** Set circle size
            ),
          ],
        ),
      ),
    );
  }
}
