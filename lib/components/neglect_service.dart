import 'dart:async';
import 'package:aerogotchi/components/levels/happiness_level_service.dart';

class NeglectService {
  static Timer? _timer;
  static const int decreaseAmount = 1; // Amount by which happiness decreases
  static const int decreaseIntervalSeconds =
      60; // Interval in seconds for decrease

  static void startNeglectTimer(Function(int) updateHappinessLevel) {
    _timer =
        Timer.periodic(Duration(seconds: decreaseIntervalSeconds), (timer) {
      _decreaseHappiness(updateHappinessLevel);
    });
  }

  static void _decreaseHappiness(Function(int) updateHappinessLevel) async {
    try {
      final currentHappinessLevel =
          await HappinessLevelService.getHappinessLevel();
      if (currentHappinessLevel != null && currentHappinessLevel > 0) {
        final newHappinessLevel = currentHappinessLevel - decreaseAmount;
        await HappinessLevelService.updateHappinessLevel(newHappinessLevel);
        updateHappinessLevel(newHappinessLevel);
      }
    } catch (e) {
      print('Error decreasing happiness level: $e');
    }
  }

  static void cancelNeglectTimer() {
    _timer?.cancel();
    _timer = null;
  }
}
