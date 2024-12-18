// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDW7HjBCTMFmCFEg3Mfn01bxgupWDxkBus',
    appId: '1:1077089970634:web:8fd2ca0b50c7c06ac00733',
    messagingSenderId: '1077089970634',
    projectId: 'proyectof-853e2',
    authDomain: 'proyectof-853e2.firebaseapp.com',
    storageBucket: 'proyectof-853e2.firebasestorage.app',
    measurementId: 'G-7GVP5NBV7B',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDNJ880e6ld7ymbTtRmaFGp8yd1exPc0uU',
    appId: '1:1077089970634:android:d046a0233af85a91c00733',
    messagingSenderId: '1077089970634',
    projectId: 'proyectof-853e2',
    storageBucket: 'proyectof-853e2.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDwYkPQ_AskxE8bm2ootB99kGxSnDwKIlg',
    appId: '1:1077089970634:ios:b198efdb447dd67dc00733',
    messagingSenderId: '1077089970634',
    projectId: 'proyectof-853e2',
    storageBucket: 'proyectof-853e2.firebasestorage.app',
    iosClientId: '1077089970634-8as5b1q5altbc23udpfh0f0275c06f2v.apps.googleusercontent.com',
    iosBundleId: 'com.example.proyecto',
  );
}
