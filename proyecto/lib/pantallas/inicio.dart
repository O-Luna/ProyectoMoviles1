import 'package:flutter/material.dart';
import 'package:proyecto/pantallas/configuracion.dart';
//import 'package:proyecto/pantallas/detalles.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/pantallas/perdidos.dart';
import 'package:proyecto/pantallas/principal.dart';
import 'package:proyecto/providers/providers.dart';

class Inicio extends StatefulWidget {
  const  Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  var currentPageIndex = 0;
   final List<Widget> _screens = [
    Principal(),
    Perdidos(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<Providers>(
      builder: (context, provider, child) {
    return Scaffold(
      appBar: [
        AppBar(
          title: const Text('Mascotas'),
          actions: [
            IconButton(onPressed: (){
              Navigator.push(
              context, 
              MaterialPageRoute(builder: (context)=>Config()));

            }, icon: Icon(Icons.settings))
          ],
        ),
        AppBar(
          title: const Text('Perdidos'),
        ),
      ][currentPageIndex],
      backgroundColor: provider.isDarkMode ? Colors.grey[900] : Colors.white,
      body: 
      _screens[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: provider.isDarkMode ? Colors.grey[800] : Colors.white,
        elevation: 0,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
            setState(() {
            currentPageIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(Icons.pets_outlined, color: Colors.blue),
            icon: Icon(Icons.pets, color: Colors.grey),
            label: 'Tus mascotas',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.crisis_alert_outlined, color: Colors.blue),
            icon: Icon(Icons.crisis_alert, color: Colors.grey),
            label: 'Mascotas perdidas',
          ),
        ]
      )
    );
    }
    );
  }
}