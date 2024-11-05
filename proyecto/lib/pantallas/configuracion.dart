import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/providers/providers.dart';

class Config extends StatefulWidget {
  const Config({super.key});

  @override
  State<Config> createState() => _ConfigState();
}
class _ConfigState  extends State<Config> {
  bool darkmode=false;
  @override
  Widget build(BuildContext context) {
    return Consumer<Providers>(
      builder: (context, provider,child){
        return Scaffold(
          appBar: AppBar(
            title: Text("Configuración"),
          ),
      body:
       Center(
          child: 
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Activar modo oscuro",style: TextStyle(fontSize: 18),),
                  Switch(
                        value: provider.isDarkMode,
                        onChanged: (value) {
                          provider.fondo();
                    
                        },
                      ),
                ]
              ),
              IconButton(
              onPressed: (){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(seconds: 3),
                    content: Text('Pendiente: Falta la forma de modificar al usuario'),
                    action: SnackBarAction(
                      label: 'Cerrar',
                      onPressed: () {
                      }
                    )
                  )
                );
              },
              icon: Icon(Icons.account_circle)),

            ElevatedButton(
              onPressed: (){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(seconds: 5),
                    content: Text('Pendiente: Falta añadir el bluetooth y su configuración'),
                    action: SnackBarAction(
                      label: 'Cerrar',
                      onPressed: () {
                      }
                    )
                  )
                );
              },
              child: Text("Configurar bluetooth"),
            ),

            ElevatedButton(
              onPressed: () async { 
                        await FirebaseAuth.instance.signOut();
              Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text("Cerrar Sesión"),
            ),
            ],
          ),
      ),
    );
    }
    

    );
  }
}
