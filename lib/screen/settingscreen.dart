import 'package:aerogotchi/components/navigation_helper.dart';
import 'package:aerogotchi/reusable_widget/background_gradient.dart';
import 'package:aerogotchi/reusable_widget/custom_settings_button.dart';
import 'package:flutter/material.dart';
import '../reusable_widget/reusable_widget.dart';

class SettingScreen extends StatefulWidget {
  final String petName;
  const SettingScreen({Key? key, required this.petName}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingsState();
}

class _SettingsState extends State<SettingScreen> {
  late TextEditingController restartController;
  late TextEditingController backController;

  @override
  void initState() {
    super.initState();
    restartController = TextEditingController();
    backController = TextEditingController();
  }

  @override
  void dispose() {
    restartController.dispose();
    backController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Adjust these variables for container width and height
    final double containerWidth = screenWidth * 0.6;
    final double containerHeight = screenHeight * 0.2;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BackgroundGradient.blueGradient,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              logoWidget("background_image/aerogotchi.png"),
              Text(
                'SETTINGS',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6354ED),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: containerWidth,
                height: containerHeight,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFF6354ED),
                  borderRadius: BorderRadius.circular(35),
                  border: Border.all(
                    color: Color(0xFF1C205E),
                    width: 3,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomSettingsButton(
                      text: 'Restart',
                       onPressed: () => navigateToPetNameScreen(context, widget.petName),
                    ),
                    CustomSettingsButton(
                      text: 'Back',
                      onPressed: () => navigateToPetViewScreen(context, widget.petName),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
