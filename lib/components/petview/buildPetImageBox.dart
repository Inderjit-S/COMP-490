import 'package:flutter/material.dart';
import 'package:aerogotchi/reusable_widget/reusable_widget.dart';

class buildPetImageBox extends StatelessWidget {
  final String petName;
  final int hungerLevel;
  final int happinessLevel;
  final int neglectTimerSeconds;
  final double width;

  const buildPetImageBox({
    Key? key,
    required this.petName,
    required this.hungerLevel,
    required this.happinessLevel,
    required this.neglectTimerSeconds,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF666D8C),
        borderRadius: BorderRadius.circular(46),
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      width: width,
      height: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SmallerlogoWidget("background_image/aerogotchi.png"),
          const SizedBox(height: 5),
          Text(
            '$petName',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Hunger Level: $hungerLevel',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Happiness Level: $happinessLevel',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          Text(
            'Neglect Timer: $neglectTimerSeconds seconds',
            // 'Neglect Timer: 0 seconds',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
