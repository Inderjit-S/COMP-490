import 'package:firebase_database/firebase_database.dart';
import 'dart:math';
import 'dart:developer'; 

class PersonalityService {
  static Future<int> getPersonality() async {
    final dbRefpers = FirebaseDatabase.instance.ref().child('personality');
    final snapshot = await dbRefpers.get(); 
    final data = snapshot.value;
    if (data is int) {
      return data;
    } else {
      throw Exception('Invalid data type');
    }
  }

  static Future<void> updatePersonality(int value) async {
    final dbRefpersonality = FirebaseDatabase.instance.ref().child('personality');
    await dbRefpersonality.set(value).catchError((error) {
      print('Error updating personality: $error');
      throw Exception('Failed to update personality value: $value');
    });
  }

  int getRandomNumber() {
    final Random random = Random();
    return random.nextInt(3) + 1; // nextInt(3) generates 0, 1, or 2. Adding 1 makes it 1, 2, or 3.
  }

  void initPersonality() async {
    int rng = getRandomNumber();
    await updatePersonality(rng);
  }
}


