import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationHandler {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  void initialize() {
    _setupMessageHandlers();
  }

  void _setupMessageHandlers() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received message while app is in foreground: $message');
      _handleReceivedMessage(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked! $message');
    });
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
    _handleReceivedMessage(message);
  }

  void _handleReceivedMessage(RemoteMessage message) {
    final title = message.notification?.title;
    final body = message.notification?.body;

    if (title != null && body != null) {
      sendNotification(title: title, body: body);
    }
  }

  Future<void> sendNotification(
      {required String title, required String body}) async {
    print('Received notification - Title: $title, Body: $body');
  }

  Future<void> initNotifications() async {
    await _messaging.requestPermission();
    final fCMToken = await getFCMToken();
    print('FCM Token: $fCMToken');
  }

  Future<String?> getFCMToken() async {
    return await _messaging.getToken();
  }
}
