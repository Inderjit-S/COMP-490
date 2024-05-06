import 'package:firebase_database/firebase_database.dart';

class HappinessLevelService {
  static const int maxHappinessLevel = 10;

  static Future<int> getHappinessLevel() async {
    final dbRefHappiness =
        FirebaseDatabase.instance.reference().child('happiness_level');
    final snapshot = await dbRefHappiness.once();
    final data = snapshot.snapshot.value;
    if (data is int) {
      return data;
    } else {
      throw Exception('Invalid data type');
    }
  }

  static Future<void> updateHappinessLevel(int level) async {
    final dbRefHappiness =
        FirebaseDatabase.instance.reference().child('happiness_level');
    await dbRefHappiness.set(level).catchError((error) {
      print('Error updating happiness level: $error');
      throw Exception('Failed to update happiness level');
    });
  }

  static Future<void> decreaseHappinessLevel(int decrement) async {
    try {
      final currentHappinessLevel = await getHappinessLevel();
      final newHappinessLevel =
          (currentHappinessLevel - decrement).clamp(0, maxHappinessLevel);
      await updateHappinessLevel(newHappinessLevel);
        } catch (e) {
      print('Error decreasing happiness level: $e');
    }
  }

  static Future<void> tryUpdateHappinessLevel(int increment) async {
    try {
      final currentHappinessLevel = await getHappinessLevel();
      final newHappinessLevel = currentHappinessLevel + increment;
      if (newHappinessLevel <= maxHappinessLevel) {
        await updateHappinessLevel(newHappinessLevel);
      } else {
        await updateHappinessLevel(maxHappinessLevel);
      }
        } catch (e) {
      print('Error updating happiness level: $e');
    }
  }
}
