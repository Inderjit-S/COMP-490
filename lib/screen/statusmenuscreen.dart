import 'package:aerogotchi/components/levels/happiness_level_service.dart';
import 'package:aerogotchi/components/levels/hunger_level_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart'; // Import Firebase Realtime Database

class StatusMenuScreen extends StatefulWidget {
  const StatusMenuScreen({Key? key});

  @override
  _StatusMenuScreenState createState() => _StatusMenuScreenState();
}

class _StatusMenuScreenState extends State<StatusMenuScreen> {
  // Set stats values here
  int energyLevel = 0;
  int hungerLevel = 0;
  int happinessLevel = 0;

  @override
  void initState() {
    super.initState();
    // Initialize the level variables
    getEnergyLvl().then((value) {
      setState(() {
        energyLevel = value;
      });
    });
    HungerLevelService.getHungerLevel().then((value) {
      setState(() {
        hungerLevel = value;
      });
    }).catchError((error) {
      print('Error fetching hunger level: $error');
    });
    HappinessLevelService.getHappinessLevel().then((value) {
      setState(() {
        happinessLevel = value;
      });
    }).catchError((error) {
      print('Error fetching happiness level: $error');
    });
  }

  // Functions to retrieve the Energy,Happiness,Hunger name from the database
  Future<int> getEnergyLvl() async {
    final dbRefEnergy =
        FirebaseDatabase.instance.reference().child('energy_level');
    final snapshot = await dbRefEnergy.once();
    final data = snapshot.snapshot.value;
    if (data is int) {
      return data;
    } else {
      throw Exception('Invalid data type');
    }
  }

  // *************************************

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(130.0), // Increased height of app bar
        child: AppBar(
          backgroundColor:
              Colors.transparent, // Set app bar background to transparent
          elevation: 0, // Remove app bar elevation
          flexibleSpace: Container(
            padding: const EdgeInsets.only(top: 75.0), // Adjust top padding
            child: const Center(
              child: Text(
                'PET STATUS',
                style: TextStyle(
                  color: Color(0xFFAC90FF),
                  fontSize: 32.0, // Increased font size
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Color(0xFF4660E8),
                      offset: Offset(
                        0, 8, // Adjust the offset to create a lifting effect
                      ),
                      blurRadius:
                          6, // Increase blur radius for a more prominent shadow
                    ),
                  ],
                ),
              ),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Navigate back to the previous screen
              Navigator.pop(context);
            },
            color: const Color.fromARGB(68, 0, 0, 0)
                .withOpacity(0.3), // Lower opacity of back button
          ),
        ),
      ),
      extendBodyBehindAppBar: true, // Extend body behind app bar
      body: Container(
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Add your status bars here
              StatusBar(
                icon: Icons.flash_on, // Lightning bolt icon
                label: 'Energy', // Energy status label
                level: energyLevel, // Energy level
                iconColor: Colors.yellow, // Yellow color for the icon
                circleColor: const Color.fromARGB(
                    147, 0, 0, 0), // Color of the outline BARS
                circleSize: 60, // ***CIRCLE*** Set circle size
              ),
              const SizedBox(
                  height: 20), // Adjust the space between status bars
              StatusBar(
                icon: Icons.fastfood, // Burger icon
                label: 'Hunger', // Hunger status label
                level: hungerLevel, // Hunger level
                iconColor: Colors.blue[900]!, // Dark blue color for the icon
                circleColor: const Color.fromARGB(
                    147, 0, 0, 0), // Color of the outline BARS
                circleSize: 60, // ***CIRCLE*** Set circle size
              ),
              const SizedBox(
                  height: 20), // Adjust the space between status bars
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
      ),
    );
  }
}

class StatusBar extends StatelessWidget {
  final IconData icon;
  final String label;
  final int level;
  final Color iconColor;
  final Color circleColor;
  final double circleSize;

  const StatusBar({
    Key? key,
    required this.icon,
    required this.label,
    required this.level,
    required this.iconColor,
    required this.circleColor,
    required this.circleSize,
  });

  @override
  Widget build(BuildContext context) {
    double fillPercentage = (level / 10) * 100; // Calculate fill percentage

    if (level > 10) {
      fillPercentage = 100;
    }

    Color statusColor = _getStatusColor(level);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(
              3), // Add padding to create an outline effect CIRCLE
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: circleColor, // Color of the circle
          ),
          height: circleSize, // ***CIRCLE*** Set circle size
          width: circleSize,
          child: Container(
            padding: const EdgeInsets.all(
                4), // Add padding to create an outline effect
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(150, 176, 248,
                  255), // Color of the outline INSIDE CIRCLES ICON
            ),
            child: Icon(
              icon,
              size: 40, // Smaller icon size ***ICON***
              color: iconColor,
            ),
          ), // ***CIRCLE*** Set circle size
        ),
        const SizedBox(width: 20),
        Column(
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold, // Bold font weight
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: 250,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(
                      147, 0, 0, 0), // Color of the outline BARS
                  width: 2, // Thickness of the outline
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Container(
                    width: 250,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: fillPercentage / 100, // Adjust fill percentage
                    child: Container(
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color _getStatusColor(int level) {
    if (level >= 7) {
      return Colors.green;
    } else if (level >= 4) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }
}
