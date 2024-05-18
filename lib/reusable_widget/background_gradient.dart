import 'package:flutter/material.dart';

class BackgroundGradient {
  static final BoxDecoration blueGradient = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.blue[800]!,
        Colors.blue[400]!,
      ],
    ),
  );
}
