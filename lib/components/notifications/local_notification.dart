import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationHandler {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialize local notifications
  Future<void> initNotifications() async {
    // Initialization settings for local notifications

    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // For iOS, you need to specify some settings
    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: false, // Request permission to display alerts.
      requestBadgePermission: false, // Request permission to update the badge.
      requestSoundPermission: false, // Request permission to play sounds.
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    // Initialize the plugin
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Method to display a local notification
  Future<void> showNotification(
      {required String title, required String body}) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = DarwinNotificationDetails(); // Corrected
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics); // Corrected

    // Display the notification
    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }
}
