import 'package:aerogotchi/components/levels/energy_level_service.dart';
import 'package:aerogotchi/components/levels/happiness_level_service.dart';
import 'package:aerogotchi/components/levels/hunger_level_service.dart';
import 'package:firebase_database/firebase_database.dart';

class LevelService {
  static Future<int> getLevel(String childName) async {
    final dbRef = FirebaseDatabase.instance.reference().child(childName);
    final snapshot = await dbRef.once();
    final data = snapshot.snapshot.value;
    if (data is int) {
      return data;
    } else {
      throw Exception('Invalid data type for $childName');
    }
  }

  static Future<void> updateLevel(String childName, int level) async {
    final dbRef = FirebaseDatabase.instance.reference().child(childName);
    await dbRef.set(level).catchError((error) {
      print('Error updating $childName level: $error');
      throw Exception('Failed to update $childName level');
    });
  }

  static Future<void> tryUpdateLevel(
      String childName, int increment, int maxValue) async {
    try {
      final currentLevel = await getLevel(childName);
      if (currentLevel != null) {
        final newLevel = (currentLevel + increment).clamp(0, maxValue);
        await updateLevel(childName, newLevel);
      }
    } catch (e) {
      print('Error updating $childName level: $e');
    }
  }
}

class LevelFetchService {
  static Future<void> fetchEnergyLevel(Function(int) setState) async {
    try {
      final value = await EnergyLevelService.getEnergyLevel();
      setState(value);
    } catch (error) {
      print('Error fetching energy level: $error');
    }
  }

  static Future<void> fetchHungerLevel(Function(int) setState) async {
    try {
      final value = await HungerLevelService.getHungerLevel();
      setState(value);
    } catch (error) {
      print('Error fetching hunger level: $error');
    }
  }

  static Future<void> fetchHappinessLevel(Function(int) setState) async {
    try {
      final value = await HappinessLevelService.getHappinessLevel();
      setState(value);
    } catch (error) {
      print('Error fetching happiness level: $error');
    }
  }
}
