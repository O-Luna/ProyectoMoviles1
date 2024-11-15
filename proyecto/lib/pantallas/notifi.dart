import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Title del mensaje: ${message.notification?.title}");
  print("Body del mensaje: ${message.notification?.body}");
  print("ID del mensaje: ${message.messageId}");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notifications Test',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Testing Notifications...'),
        ),
        body: const Center(
          child: ElevatedButton(
            onPressed: _getToken,
            child: Text("Get Token")),
        ),
      ),
    );
  }
}

void _getToken() async {
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print("Token conseguido y copiado al portapapeles: ${fcmToken}");
  await Clipboard.setData(ClipboardData(text: "$fcmToken"));
}