import 'package:flutter/material.dart';

class StatusBar extends StatelessWidget {
  final IconData icon;
  final String label;
  final int level;
  final Color iconColor;
  final Color circleColor;
  final double circleSize;

  const StatusBar({
    Key? key,
    required this.icon,
    required this.label,
    required this.level,
    required this.iconColor,
    required this.circleColor,
    required this.circleSize,
  });

  @override
  Widget build(BuildContext context) {
    double fillPercentage = (level / 10) * 100; // Calculate fill percentage

    if (level > 10) {
      fillPercentage = 100;
    }
    Color statusColor =
        _getStatusColor(level); // Use the method from this class

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(
              3), // Add padding to create an outline effect CIRCLE
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: circleColor, // Color of the circle
          ),
          height: circleSize, // ***CIRCLE*** Set circle size
          width: circleSize,
          child: Container(
            padding: const EdgeInsets.all(
                4), // Add padding to create an outline effect
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(150, 176, 248,
                  255), // Color of the outline INSIDE CIRCLES ICON
            ),
            child: Icon(
              icon,
              size: 40, // Smaller icon size ***ICON***
              color: iconColor,
            ),
          ), // ***CIRCLE*** Set circle size
        ),
        const SizedBox(width: 20),
        Column(
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold, // Bold font weight
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: 250,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(
                      147, 0, 0, 0), // Color of the outline BARS
                  width: 2, // Thickness of the outline
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Container(
                    width: 250,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: fillPercentage / 100, // Adjust fill percentage
                    child: Container(
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color _getStatusColor(int level) {
    if (level >= 7) {
      return Colors.green;
    } else if (level >= 4) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }
}
