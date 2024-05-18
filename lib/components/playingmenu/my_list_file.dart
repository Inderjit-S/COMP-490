import 'package:flutter/material.dart';

Widget myListTile(int index, String title, String description, int selectedOptionIndex, Function(int) onTap) {
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
              fontSize: 22.0,
              shadows: selectedOptionIndex == index
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : [],
            ),
          ),
        ),
        onTap: () {
          onTap(index);
        },
      ),
      const SizedBox(height: 0.5),
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            description,
            style: TextStyle(
              color: const Color.fromRGBO(255, 255, 255, 0.525).withOpacity(0.6),
              fontSize: 13.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ],
  );
}
