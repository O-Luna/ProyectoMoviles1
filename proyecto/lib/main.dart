import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/pantallas/inicio_sesion.dart';
import 'package:proyecto/firebase/login.dart';
import 'package:proyecto/providers/providers.dart';
import 'package:proyecto/firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => Providers(),
      child: MyApp(),
    ),

  );
}



class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Consumer<Providers>(
      builder: (context, provider, child) {
        return MaterialApp(
          theme: provider.currentTheme,
         // home: InicioSesion(),
         home: AuthGate(),
        );
      },
    );
  }
}
