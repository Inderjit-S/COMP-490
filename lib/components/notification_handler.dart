import 'package:firebase_messaging/firebase_messaging.dart';

  Future<void> handleBackgroundMessage(RemoteMessage message) async{
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Payload: ${message.data}');
    
  }
class FirebaseNotificationHandler {
   FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Initialize Firebase Messaging
   void initialize() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received message while app is in foreground: $message');
      // Handle foreground messages
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked! $message');
      // Handle notification click when app is in background
    });
  }

  // Handle background messages
   Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
    // Handle background messages
  }

   Future<void>initNotifications()async{
    await messaging.requestPermission();
    final fCMToken = await messaging.getToken();
    print('Token: $fCMToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  // Subscribe to a topic
   void subscribeToTopic(String topic) {
    messaging.subscribeToTopic(topic);
  }

  // Unsubscribe from a topic
   void unsubscribeFromTopic(String topic) {
    messaging.unsubscribeFromTopic(topic);
  }

  // Get FCM token
   Future<String?> getFCMToken() async {
    return await messaging.getToken();
  }
}
