import 'package:firebase_database/firebase_database.dart';

class PersonalityService {
  static Future<int> getPersonality() async {
    final dbRefpers =
        FirebaseDatabase.instance.reference().child('personality');
    final snapshot = await dbRefpers.once();
    final data = snapshot.snapshot.value;
    if (data is int) {
      return data;
    } else {
      throw Exception('Invalid data type');
    }
  }
}
