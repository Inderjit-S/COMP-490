import 'package:firebase_database/firebase_database.dart';

class HungerLevelService {
  static final int maxValue = 10;

  static int calculateNewHungerLevel(int currentLevel, int increment) {
    final newLevel = currentLevel + increment;
    return newLevel > maxValue ? maxValue : newLevel;
  }

  static Future<void> tryUpdateHungerLevel(int increment) async {
    try {
      final currentHungerLevel = await getHungerLevel();
      if (currentHungerLevel != null) {
        final newHungerLevel = calculateNewHungerLevel(currentHungerLevel, increment);
        await updateHungerLevel(newHungerLevel);
      }
    } catch (e) {
      print('Error updating hunger level: $e');
    }
  }

  static Future<int> getHungerLevel() async {
    final dbRefHunger = FirebaseDatabase.instance.reference().child('hunger_level');
    final snapshot = await dbRefHunger.once();
    final data = snapshot.snapshot.value;
    if (data is int) {
      return data;
    } else {
      throw Exception('Invalid data type');
    }
  }

  static Future<void> updateHungerLevel(int level) async {
    final dbRefHunger = FirebaseDatabase.instance.reference().child('hunger_level');
    await dbRefHunger.set(level).catchError((error) {
      print('Error updating hunger level: $error');
      throw Exception('Failed to update hunger level');
    });
  }
}
