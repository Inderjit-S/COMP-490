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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BackgroundGradient.blueGradient,
            ),
            Positioned.fill(
              top: MediaQuery.of(context).padding.top,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            children: <Widget>[
                              buildImageWithText('background_image/aerogotchi.png', 'Not Hungry\nNot Excited'),
                              buildImageWithText('background_image/aeroexcited.png', 'Not Hungry\nExcited'),
                              buildImageWithText('background_image/aerounhappy.png', 'Hungry'),
                              buildImageWithText('background_image/aerosleepy.png', 'Low Battery'),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white.withOpacity(0.7)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Text(
                                  'Aerogotchi will display one of four faces based on its current status.',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'You can check the status levels in the Pet Status Menu designated by the green icon with the ECG symbol.',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
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
      ),
    );
  }

  Widget buildImageWithText(String imagePath, String text) {
    return Center(
      child: Column(
        children: <Widget>[
          Image.asset(imagePath),
          Text(
            text,
            style: TextStyle(
               color: Colors.white.withOpacity(0.85),

              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
