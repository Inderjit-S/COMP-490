import 'package:flutter/material.dart';
import 'package:aerogotchi/reusable_widget/background_gradient.dart';
import 'package:aerogotchi/reusable_widget/custom_petview_app_bar.dart';

class AeroFacesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomPetViewAppBar(
        titleText: 'Aero Faces',
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
                        GridView.count(
                          crossAxisCount: 2,
                          children: <Widget>[
                            buildImageWithText('assets/images/aerogotchi.png', 'Not Hungry\nNot Excited'),
                            buildImageWithText('assets/images/aeroexcited.png', 'Not Hungry\nExcited'),
                            buildImageWithText('assets/images/aerounhappy.png', 'Hungry'),
                            buildImageWithText('assets/images/aerosleepy.png', 'Low Battery'),
                          ],
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Aerogotchi will display one of four faces based on its current status. You can check the status levels in the Pet Status Menu designated by the green icon with the ECG symbol.',
                          ),
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

  Widget buildImageWithText(String imagePath, String text) {
    return Center(
      child: Column(
        children: <Widget>[
          Image.asset(imagePath),
          Text(text),
        ],
      ),
    );
  }
}
