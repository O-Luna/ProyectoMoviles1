import 'package:flutter/material.dart';
import 'package:proyecto/pantallas/principal.dart';
import 'package:proyecto/informacion/category.dart';
class InicioSesion extends StatefulWidget {
  const InicioSesion({super.key});

  @override
  State<InicioSesion> createState() => _InicioSesionState();
}

class _InicioSesionState extends State<InicioSesion> {
    TextEditingController firstFieldController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        
        child: 
        Padding(padding: const EdgeInsets.fromLTRB(130, 10, 130, 0),
        child: 
         Column( 
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            TextField(
              controller: firstFieldController,
              keyboardType: TextInputType.text, 
              decoration: const InputDecoration(
              labelText: 'Usuario',
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              border: OutlineInputBorder()
              )
            ),
            Padding(padding: const EdgeInsets.fromLTRB(5, 5, 0, 0)),
            TextField(
              controller: firstFieldController,
              keyboardType: TextInputType.text, 
              decoration: const InputDecoration(
              labelText: 'Contraseña',
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              border: OutlineInputBorder()
              )
            ),
            ElevatedButton(onPressed: (){
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context)=>Principal()));
        },
        child: Text("Iniciar sesión"),),
          ],
         )
        )        
      ),

    );
  }
}







