import 'dart:async';

class HungerLevelTimer {
  late Timer _timer;
  final Function(int) updateHungerLevel;

  HungerLevelTimer({required this.updateHungerLevel});

  void startTimer(int initialHungerLevel) {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) { // Decrease hunger level every 5 seconds
      if (initialHungerLevel > 0) {
        initialHungerLevel--; 
        updateHungerLevel(initialHungerLevel);
      }
    });
  }

  void cancelTimer() {
    _timer.cancel();
  }
}
