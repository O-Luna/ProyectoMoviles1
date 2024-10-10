import 'package:flutter/material.dart';
import 'package:proyecto/informacion/mascotas.dart';
import 'package:proyecto/informacion/modelo.dart';
import 'package:proyecto/pantallas/configuracion.dart';
import 'package:proyecto/informacion/category.dart';
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
      body: 

      GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 1.5,
        crossAxisSpacing: 12,
        mainAxisSpacing: 10,
      ),

      itemCount: mascota.length,
      itemBuilder: (context, index) {
        final category = mascota[index];
        return InkWell(
         /* onTap: () {
            Navigator.push(context,
            MaterialPageRoute(builder: (context)=> Category(categoryId: category.id,),
            ));
          },*/
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  category.color,
                  category.color,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.title,
                  style: TextStyle(color: Colors.white)
                  ),
                
              ],
            ),
          ),
        );
      },
    ),
      bottomNavigationBar: NavigationBar(
      selectedIndex: currentPageIndex,
      onDestinationSelected: (int index){

      },
      destinations: [
        NavigationDestination(
          selectedIcon: Icon(Icons.pets_outlined),
          icon: Icon(Icons.pets),
          label: 'Tus mascotas',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.crisis_alert_outlined),
          icon: Icon(Icons.crisis_alert),
          label: 'Mascotas perdidas',
        ),
      ]
      
      )

    );
    
    

  }
}
