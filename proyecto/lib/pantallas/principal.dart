import 'package:flutter/material.dart';
import 'package:proyecto/pantallas/configuracion.dart';
class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  var currentPageIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quien dejó a los perros afuera"),
        actions: [IconButton(onPressed: (){
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context)=>Config()));

        }, icon: Icon(Icons.sunny))],
      ),
      bottomNavigationBar: NavigationBar(
      selectedIndex: currentPageIndex,
      onDestinationSelected: (int index){

      },
      destinations: [
        NavigationDestination(
          selectedIcon: Icon(Icons.set_meal_outlined),
          icon: Icon(Icons.set_meal),
          label: 'categories'
      
        ),
      ]
      
      )

    );
    
    

  }
}
