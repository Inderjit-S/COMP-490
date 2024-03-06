import 'package:aerogotchi/components/levels/happiness_level_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class PlayingMenuScreen extends StatefulWidget {
  const PlayingMenuScreen({super.key});

  @override
  _PlayingMenuScreenState createState() => _PlayingMenuScreenState();
}

class _PlayingMenuScreenState extends State<PlayingMenuScreen> {
  int selectedOptionIndex = -1; // Initialize with no selected option
  final DatabaseReference dbRefHappiness =
      FirebaseDatabase.instance.reference().child('happiness_level');

  void navigateToTempScreenAndUpdateHappiness(int index) async {
    // Navigate to the temporary screen for the selected option
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => getTempScreen(selectedOptionIndex)),
    );

    // Update happiness level
    await HappinessLevelService.tryUpdateHappinessLevel(2);
  }

  @override
  Widget build(BuildContext context) {
    // Get screen height
    final screenHeight = MediaQuery.of(context).size.height;

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
                'PLAYING MENU',
                style: TextStyle(
                  color: Color(0xFFAC90FF),
                  fontSize: 32.0, // Increased font size
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Color(0xFF4660E8),
                      offset: Offset(
                          0, 8), // Adjust the offset to create a lifting effect
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 25, // Adjust the space between app bar and menu options
            ),
            Expanded(
              child: ListView(
                itemExtent: 95.0, // Fixed height for each menu option
                children: <Widget>[
                  buildListTile(0, 'Sky-Shuffle', 'Dance'),
                  buildListTile(1, 'Follow the Leader', 'Following Game'),
                  buildListTile(2, 'Photo Pilot', 'Photoshoot'),
                ],
              ),
            ),
            // Show description if an option is selected
            if (selectedOptionIndex != -1)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    20.0, 0, 20.0, 20.0), // Adjust bottom inset
                child: Container(
                  child: Text(
                    getDescription(selectedOptionIndex),
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 18.0, // Increased font size for description
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            // Show Go button if an option is selected
            if (selectedOptionIndex != -1)
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 16.0, left: 16.0, right: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => navigateToTempScreenAndUpdateHappiness(
                        selectedOptionIndex),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(
                            vertical: 40,
                            horizontal: 40), // Adjust inset padding
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.transparent),
                      foregroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors
                                .white; // Change color to white when hovered
                          }
                          return Colors.white.withOpacity(0.2); // Default color
                        },
                      ),
                      side: MaterialStateProperty.all<BorderSide>(
                          BorderSide(color: Colors.white.withOpacity(0.05))),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.horizontal(),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Go',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Widget to build each menu option
  Widget buildListTile(int index, String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Center(
            child: Text(
              title,
              style: TextStyle(
                color: selectedOptionIndex == index
                    ? Colors.white
                    : Colors.white.withOpacity(0.5),
                fontWeight: selectedOptionIndex == index
                    ? FontWeight.bold
                    : FontWeight.normal,
                fontSize: 22.0, // Increased font size for options
                shadows: selectedOptionIndex == index
                    ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [], // Apply shadow if selected
              ),
            ),
          ),
          onTap: () {
            setState(() {
              selectedOptionIndex = index;
            });
          },
        ),
        const SizedBox(
            height: 0.5), // Adjust the space between title and description
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              description,
              style: TextStyle(
                color:
                    const Color.fromRGBO(255, 255, 255, 0.525).withOpacity(0.6),
                fontSize: 13.0, // Font size for description
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  // Method to get description based on index
  String getDescription(int index) {
    switch (index) {
      case 0:
        return '"Sky-Shuffle is a high-flying dance experience!"';
      case 1:
        return '"Follow the Leader is a fun following game!"';
      case 2:
        return '"Photo Pilot is an exciting photo shoot adventure!"';
      default:
        return '';
    }
  }

  // Method to get title based on index
  String getTitle(int index) {
    switch (index) {
      case 0:
        return 'Sky-Shuffle';
      case 1:
        return 'Follow the Leader';
      case 2:
        return 'Photo Pilot';
      default:
        return '';
    }
  }

  // Temp Screen Widgets
  // (These can be in separate files if preferred)

  Widget getTempScreen(int index) {
    switch (index) {
      case 0:
        return TempScreenPM1(optionName: getTitle(index));
      case 1:
        return TempScreenPM2(optionName: getTitle(index));
      case 2:
        return TempScreenPM3(optionName: getTitle(index));
      default:
        return Container();
    }
  }
}

class TempScreenPM1 extends StatelessWidget {
  final String optionName;

  const TempScreenPM1({Key? key, required this.optionName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(optionName),
      ),
      body: Center(
        child: Text(
          'This is a temporary screen for $optionName',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class TempScreenPM2 extends StatelessWidget {
  final String optionName;

  const TempScreenPM2({Key? key, required this.optionName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(optionName),
      ),
      body: Center(
        child: Text(
          'This is a temporary screen for $optionName',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class TempScreenPM3 extends StatelessWidget {
  final String optionName;

  const TempScreenPM3({Key? key, required this.optionName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(optionName),
      ),
      body: Center(
        child: Text(
          'This is a temporary screen for $optionName',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
