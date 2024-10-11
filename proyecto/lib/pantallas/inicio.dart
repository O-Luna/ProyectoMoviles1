import 'package:flutter/material.dart';
import 'package:proyecto/informacion/mascotas.dart';
import 'package:proyecto/pantallas/configuracion.dart';
import 'package:proyecto/pantallas/detalles.dart';
import 'package:proyecto/pantallas/perdidos.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  var currentPageIndex = 0;
   final List<Widget> _screens = [
    Principal(),
    Perdidos(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5), // Fondo gris claro elegante
      body: 
      _screens[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
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
}