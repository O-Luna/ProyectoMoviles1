import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/pantallas/inicio_sesion.dart';
import 'package:proyecto/providers/providers.dart';

void main() {
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
          home: InicioSesion(),
        );
      },
    );
  }
}
