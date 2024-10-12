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
                  Switch(
                        value: provider.isDarkMode,
                        onChanged: (value) {
                          provider.fondo();
                    
                        },
                      ),
              ElevatedButton(
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
              child: Text("Modificar usuario"),
            ),

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
              onPressed: (){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(seconds: 5),
                    content: Text('Pendiente: Falta la forma de poder cerrar sesión'),
                    action: SnackBarAction(
                      label: 'Cerrar',
                      onPressed: () {
                      }
                    )
                  )
                );
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
