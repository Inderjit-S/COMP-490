import 'package:firebase_database/firebase_database.dart';

class EventService {
  static Future<String> getEvent() async {
    final dbRefEvent = FirebaseDatabase.instance.reference().child('event');
    final snapshot = await dbRefEvent.once();
    final data = snapshot.snapshot.value;
    return data.toString();
  }

  static Future<void> updateEvent(String event) async {
    final dbRefHunger = FirebaseDatabase.instance.reference().child('event');
    await dbRefHunger.set(event).catchError((error) {
      print('Error updating Event: $error');
      throw Exception('Failed to update Event');
    });
  }

  static Future<bool> getTakePhoto() async {
    final dbRefEvent =
        FirebaseDatabase.instance.reference().child('take_photo');
    final snapshot = await dbRefEvent.once();
    final data = snapshot.snapshot.value;
    // Assuming the data retrieved is always a boolean
    return data as bool? ?? false; // Default value is false if data is null
  }

  static Future<void> updateTakePhoto(bool takePhoto) async {
    final dbRefTakePhoto =
        FirebaseDatabase.instance.reference().child('take_photo');
    await dbRefTakePhoto.set(takePhoto).catchError((error) {
      print('Error updating Take Photo: $error');
      throw Exception('Failed to update Take Photo');
    });
  }
}

class EventFetchService {
  static Future<void> fetchEvent(Function(String) setState) async {
    try {
      final value = await EventService.getEvent();
      setState(value);
    } catch (error) {
      print('Error fetching event: $error');
    }
  }
}
