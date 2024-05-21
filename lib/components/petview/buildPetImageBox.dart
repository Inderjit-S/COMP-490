import 'dart:async';
import 'package:flutter/material.dart';
import 'package:aerogotchi/reusable_widget/reusable_widget.dart';

class buildPetImageBox extends StatefulWidget {
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
  _buildPetImageBoxState createState() => _buildPetImageBoxState();
}

class _buildPetImageBoxState extends State<buildPetImageBox> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String image;
    if (widget.hungerLevel <= 3) {
      image = "background_image/aerounhappy.png";
    } else if (widget.hungerLevel <= 7) {
      image = "background_image/aerooriginal.png";
    } else {
      image = "background_image/aeroexcited.png";
    }

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF666D8C),
        borderRadius: BorderRadius.circular(46),
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      width: widget.width,
      height: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SmallerlogoWidget(image),
          const SizedBox(height: 10),
          Text(
            '"${widget.petName}"',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
            ),
          ),
          // const SizedBox(height: 5),
          // Text(
          //   'Hunger Level: ${widget.hungerLevel}',
          //   style: const TextStyle(
          //     color: Colors.white,
          //     fontSize: 20,
          //   ),
          // ),
          // const SizedBox(height: 5),
          // Text(
          //   'Happiness Level: ${widget.happinessLevel}',
          //   style: const TextStyle(
          //     color: Colors.white,
          //     fontSize: 20,
          //   ),
          // ),
          // Text(
          //   'Neglect Timer: ${widget.neglectTimerSeconds} seconds',
          //   style: const TextStyle(
          //     color: Colors.white,
          //     fontSize: 20,
          //   ),
          // ),
        ],
      ),
    );
  }
}
