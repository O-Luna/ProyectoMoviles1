import 'package:flutter/material.dart';

class Config extends StatefulWidget {
  const Config({super.key});

  @override
  State<Config> createState() => _ConfigState();
}
class _ConfigState  extends State<Config> {
  bool checked=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configuración"),
      ),

      body: Container(
      //color: checked ? Colors.grey: Colors.green,
      child: Center(
          child: 
          Column(
            children: [
              CheckboxListTile(
              //tileColor: Colors.red,
              title: const Text('Cambiar a modo oscuro'),
              value: checked,
              onChanged:(bool? value) { 
                setState(() {
                  checked=value ??false;
                });
              },
              ),
              ElevatedButton(
              onPressed: (){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(seconds: 5),
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
    ),

    );
  }
}
