import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CircularButton extends StatelessWidget {
  final IconData? icon;
  final String? imagePath;
  final bool isSelected;
  final VoidCallback onPressed;

  const CircularButton({
    super.key,
    required this.isSelected,
    required this.onPressed,
    this.icon,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : const Color(0xFF9CAAFA),
              shape: BoxShape.circle,
              border: Border.all(
                color:
                    isSelected ? const Color(0xFF05FF00) : Colors.transparent,
                width: 4,
              ),
            ),
            child: Center(
              child: imagePath != null
                  ? Image.asset(
                      imagePath!,
                      width: 118, // Adjusted width
                      height: 118, // Adjusted height
                    )
                  : Icon(
                      icon,
                      size: 50,
                      color: isSelected
                          ? const Color(0xFF6354ED)
                          : const Color.fromARGB(255, 255, 255, 255),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}