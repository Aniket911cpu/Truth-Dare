import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance = PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> init() async {
    await Firebase.initializeApp();
    _firebaseMessaging.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!');
    });
  }

  Future<void> sendNotification(String title, String body, String token) async {
    await _firebaseMessaging.sendMessage(
      to: token,
      data: {
        'title': title,
        'body': body,
      },
    );
  }
}

class PushNotificationsPage extends StatefulWidget {
  const PushNotificationsPage({super.key});

  @override
  _PushNotificationsPageState createState() => _PushNotificationsPageState();
}

class _PushNotificationsPageState extends State<PushNotificationsPage> {
  @override
  void initState() {
    super.initState();
    PushNotificationsManager().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Push Notifications'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Example usage
            PushNotificationsManager().sendNotification(
              'Test Title',
              'Test Body',
              '<recipient_token>',
            );
          },
          child: const Text('Send Test Notification'),
        ),
      ),
    );
  }
}