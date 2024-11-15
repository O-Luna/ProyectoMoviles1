import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/firebase/login.dart';
import 'package:proyecto/providers/providers.dart';
import 'package:proyecto/firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  await FirebaseMessaging.instance.requestPermission();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(
    ChangeNotifierProvider(
      create: (context) => Providers(),
      child: MyApp(),
    ),

  );
}
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Title del mensaje: ${message.notification?.title}");
  print("Body del mensaje: ${message.notification?.body}");
  print("ID del mensaje: ${message.messageId}");
}
class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Consumer<Providers>(
      builder: (context, provider, child) {
        return MaterialApp(
          theme: provider.currentTheme,
         home: AuthGate(),
        );
      },
    );
  }
}
