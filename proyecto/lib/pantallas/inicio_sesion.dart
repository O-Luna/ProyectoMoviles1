import 'package:flutter/material.dart';
import 'package:proyecto/pantallas/principal.dart';
class InicioSesion extends StatefulWidget {
  const InicioSesion({super.key});

  @override
  State<InicioSesion> createState() => _InicioSesionState();
}

class _InicioSesionState extends State<InicioSesion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: 
        FloatingActionButton(onPressed: (){
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context)=>Principal()));

        },
        child: Text("Iniciar sesión"),),
        
      ),


    );
  }
}







