import 'package:flutter/material.dart';

class BottomActionBox extends StatelessWidget {
  final double width;
  final VoidCallback onFoodMenuPressed;
  final VoidCallback onPlayingMenuPressed;

  const BottomActionBox({
    Key? key,
    required this.width,
    required this.onFoodMenuPressed,
    required this.onPlayingMenuPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF6354ED),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF18235B),
          width: 2.0,
        ),
      ),
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Image.asset(
              'assets/icons/bluehamIcon.png',
              width: 100,
              height: 100,
            ),
            onPressed: onFoodMenuPressed,
            color: const Color(0xFF5EBBFF),
          ),
          IconButton(
            icon: Image.asset(
              'assets/icons/gameIcon.png',
              width: 100,
              height: 100,
            ),
            onPressed: onPlayingMenuPressed,
            color: const Color(0xFFF692B0),
          ),
        ],
      ),
    );
  }
}
