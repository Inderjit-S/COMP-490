import 'package:aerogotchi/components/levels/happiness_level_service.dart';
import 'package:aerogotchi/components/playingmenu/my_list_file.dart';
import 'package:aerogotchi/reusable_widget/background_gradient.dart';
import 'package:aerogotchi/reusable_widget/custom_app_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class PlayingMenuScreen extends StatefulWidget {
  const PlayingMenuScreen({Key? key}) : super(key: key);

  @override
  _PlayingMenuScreenState createState() => _PlayingMenuScreenState();
}

class _PlayingMenuScreenState extends State<PlayingMenuScreen> {
  int selectedOptionIndex = -1;
  final DatabaseReference dbRefHappiness =
      FirebaseDatabase.instance.reference().child('happiness_level');

  void navigateToTempScreenAndUpdateHappiness(int index) async {
    // Navigate to the temporary screen for the selected option
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => getTempScreen(selectedOptionIndex),
      ),
    );

    // Update happiness level
    await HappinessLevelService.tryUpdateHappinessLevel(2);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(titleText: 'PLAYING MENU'),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BackgroundGradient.blueGradient,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 25),
            Expanded(
              child: ListView(
                itemExtent: 95.0,
                children: <Widget>[
                  myListTile(0, 'Sky-Shuffle', 'Dance', selectedOptionIndex, handleTileTap),
                  myListTile(1, 'Follow the Leader', 'Following Game', selectedOptionIndex, handleTileTap),
                  myListTile(2, 'Photo Pilot', 'Photoshoot', selectedOptionIndex, handleTileTap),
                ],
              ),
            ),
            if (selectedOptionIndex != -1) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
                child: Container(
                  child: Text(
                    getDescription(selectedOptionIndex),
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 16.0, left: 16.0, right: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () =>
                        navigateToTempScreenAndUpdateHappiness(selectedOptionIndex),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.transparent),
                      foregroundColor:
                          MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.white; // Change color to white when hovered
                          }
                          return Colors.white.withOpacity(0.2); // Default color
                        },
                      ),
                      side: MaterialStateProperty.all<BorderSide>(
                          BorderSide(color: Colors.white.withOpacity(0.05))),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
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
          ],
        ),
      ),
    );
  }

  void handleTileTap(int index) {
    setState(() {
      selectedOptionIndex = index;
    });
  }

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

  Widget getTempScreen(int index) {
    switch (index) {
      case 0:
      case 1:
      case 2:
        return TempScreen(optionName: getTitle(index));
      default:
        return Container();
    }
  }

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
}

class TempScreen extends StatelessWidget {
  final String optionName;

  const TempScreen({Key? key, required this.optionName}) : super(key: key);

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