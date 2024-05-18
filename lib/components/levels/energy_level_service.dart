import 'package:firebase_database/firebase_database.dart';

class EnergyLevelService {
  static Future<int> getEnergyLevel() async {
    final dbRefEnergy =
        FirebaseDatabase.instance.reference().child('energy_level');
    final snapshot = await dbRefEnergy.once();
    final data = snapshot.snapshot.value;
    if (data is int) {
      return data;
    } else {
      throw Exception('Invalid data type');
    }
  }
}
