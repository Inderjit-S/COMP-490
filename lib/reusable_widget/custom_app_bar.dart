import 'package:aerogotchi/components/levels/event_service.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final double fontSize;
  final double topPadding;

  const CustomAppBar({
    Key? key,
    required this.titleText,
    this.fontSize = 32.0,
    this.topPadding = 75.0,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(130.0);

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
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () async {
          // Set the event back to "manual"
          try {
            await EventService.updateEvent("manual");
          } catch (error) {
            print('Error updating event: $error');
          }
          try {
      await EventService.updateTakePhoto(false);
    } catch (error) {
      print('Error updating take photo: $error');
    }
          Navigator.pop(context);
        },
        color: const Color.fromARGB(68, 0, 0, 0).withOpacity(0.3),
      ),
    );
  }
}
