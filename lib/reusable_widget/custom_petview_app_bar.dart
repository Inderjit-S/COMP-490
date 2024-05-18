import 'package:aerogotchi/components/navigation_helper.dart';
import 'package:flutter/material.dart';

class CustomPetViewAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String titleText;
  final double fontSize;
  final double topPadding;
  final String petName; // Add petName as a parameter

  const CustomPetViewAppBar({
    Key? key,
    required this.titleText,
    this.fontSize = 35.0,
    this.topPadding = 75.0,
    required this.petName, // Require petName when creating the widget
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(120.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Container(
        padding: EdgeInsets.only(top: topPadding),
        child: Center(
          child: Text(
            titleText,
            style: TextStyle(
              color: Color(0xFFAC90FF),
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Color(0xFF4660E8),
                  offset: Offset(0, 8),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.logout_sharp),
          onPressed: () {
            navigateToLogoutScreen(context, petName);
          },
        ),
      ],
    );
  }
}
