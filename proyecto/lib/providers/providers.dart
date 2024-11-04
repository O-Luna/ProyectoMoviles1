import 'package:flutter/material.dart';
import 'package:proyecto/informacion/mascotas.dart';
import 'package:proyecto/informacion/modelo.dart';

class Providers with ChangeNotifier {
  bool _ActivDarkMode = false;
  bool get isDarkMode => _ActivDarkMode;

  List<Mascotas> _mascotasList = List.from(infomascotas);
  List<Mascotas> get mascotasList => _mascotasList;

  int _currentPageIndex=0;
  int get currentPageIndex => _currentPageIndex;
  void fondo() {
    _ActivDarkMode = !_ActivDarkMode;
    notifyListeners();
  }

  void pageindex(int index){
    _currentPageIndex = index;
    notifyListeners();
  }

   void reorderMascotas(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final item = _mascotasList.removeAt(oldIndex);
    _mascotasList.insert(newIndex, item);
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

