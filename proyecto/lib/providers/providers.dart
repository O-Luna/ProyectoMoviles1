import 'package:flutter/material.dart';
class Providers with ChangeNotifier {
  bool _ActivDarkMode = false;
  bool get isDarkMode => _ActivDarkMode;

  void fondo() {
    _ActivDarkMode = !_ActivDarkMode;
    notifyListeners();
  }

  ThemeData get currentTheme => _ActivDarkMode ? _darkTheme : _lightTheme;

  final _lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: const Color.fromARGB(255, 214, 214, 214),
    ),
  );

  final _darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color.fromARGB(255, 97, 96, 96),
    ),
  );
}

