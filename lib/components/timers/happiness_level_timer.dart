import 'dart:async';

class HappinessLevelTimer {
  late Timer _timer;
  final Function(int) updateHappinessLevel;

  HappinessLevelTimer({required this.updateHappinessLevel});

  void startTimer(int initialHappinessLevel) {
    _timer = Timer.periodic(Duration(minutes: 5), (timer) {
      // Decrease happiness level every
      if (initialHappinessLevel > 0) {
        initialHappinessLevel--;
        updateHappinessLevel(initialHappinessLevel);
      }
    });
  }

  void cancelTimer() {
    _timer.cancel();
  }
}
