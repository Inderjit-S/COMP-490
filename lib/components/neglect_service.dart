import 'dart:async';
import 'package:aerogotchi/components/levels/happiness_level_service.dart';

class NeglectService {
  static const Duration inactivityDuration = Duration(seconds: 5);
  static Timer? _activityTimer;

  static Duration getInactivityDuration() {
    return inactivityDuration;
  }

  // Method to start the inactivity timer
  // Inside NeglectService class

  static void startInactivityTimer() {
    _activityTimer?.cancel(); // Cancel existing timer if any
    _activityTimer = Timer(inactivityDuration, () async {
      // Decrease happiness level after specified duration of inactivity
      await HappinessLevelService.decreaseHappinessLevel(1);
      print('Happiness decreased due to neglect.');
    });
  }

  // Method to reset the inactivity timer on user activity
  static void resetInactivityTimer() {
    startInactivityTimer();
  }

  // Method to be called on user activity
  static void onUserActivity() {
    resetInactivityTimer();
  }
}
