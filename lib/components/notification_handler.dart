import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationHandler {
  FirebaseMessaging _messaging = FirebaseMessaging.instance;

  // Initialize Firebase Messaging and setup listeners
  void initialize() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received message while app is in foreground: $message');
      // Handle foreground messages
      _handleReceivedMessage(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked! $message');
      // Handle notification click when app is in background
    });
  }

  // Handle background messages
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
    // Handle background messages
    _handleReceivedMessage(message);
  }

  // Method to handle received messages
  void _handleReceivedMessage(RemoteMessage message) {
    // Extract notification title and body
    String? title = message.notification?.title;
    String? body = message.notification?.body;

    // Send notification if title and body are not null
    if (title != null && body != null) {
      sendNotification(title: title, body: body);
    }
  }

  // Send notification using onMessage.listen event
  Future<void> sendNotification(
      {required String title, required String body}) async {
    // Handle sending the notification as desired
    print('Received notification - Title: $title, Body: $body');
  }

  Future<void> initNotifications() async {
    await _messaging.requestPermission();
    final fCMToken = await getFCMToken();
    print('FCM Token: $fCMToken');
  }

  void subscribeToTopic(String topic) {
    _messaging.subscribeToTopic(topic);
  }

  void unsubscribeFromTopic(String topic) {
    _messaging.unsubscribeFromTopic(topic);
  }

  Future<String?> getFCMToken() async {
    return await _messaging.getToken();
  }
}
