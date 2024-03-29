import 'package:aerogotchi/components/levels/energy_level_service.dart';
import 'package:aerogotchi/components/levels/happiness_level_service.dart';
import 'package:aerogotchi/components/levels/hunger_level_service.dart';
import 'package:aerogotchi/components/notification_handler.dart';

class LevelFetchService {
  static Future<void> fetchEnergyLevel(Function(int) setState) async {
    try {
      final value = await EnergyLevelService.getEnergyLevel();
      setState(value);
      _checkAndSendNotification(value, "energy");
    } catch (error) {
      print('Error fetching energy level: $error');
    }
  }

  static Future<void> fetchHungerLevel(Function(int) setState) async {
    try {
      final value = await HungerLevelService.getHungerLevel();
      setState(value);
      _checkAndSendNotification(value, "hunger");
    } catch (error) {
      print('Error fetching hunger level: $error');
    }
  }

  static Future<void> fetchHappinessLevel(Function(int) setState) async {
    try {
      final value = await HappinessLevelService.getHappinessLevel();
      setState(value);
      _checkAndSendNotification(value, "happiness");
    } catch (error) {
      print('Error fetching happiness level: $error');
    }
  }

  static void _checkAndSendNotification(int value, String levelName) {
    final int threshold = 3; // Set your threshold here

    if (value < threshold) {
      // Construct and send the notification
      FirebaseNotificationHandler().sendNotification(
        title: 'Attention!',
        body: 'Your pet is low on $levelName level. Please take care!',
      );
    }
  }
}
