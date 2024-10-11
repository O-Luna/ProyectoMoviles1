import 'package:flutter/material.dart';

class Agregar extends StatefulWidget {
  const Agregar({super.key});

  @override
  State<Agregar> createState() => _AgregarState();
}

class _AgregarState extends State<Agregar> {
  TextEditingController firstFieldController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Mascota'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50, 150, 50, 370),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [          
            TextField(
              controller: firstFieldController,
              keyboardType: TextInputType.text, 
              decoration: const InputDecoration(
              labelText: 'Nombre',
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              border: OutlineInputBorder()
              )
            ),
        
            TextField(
              controller: firstFieldController,
              keyboardType: TextInputType.text, 
              decoration: const InputDecoration(
              labelText: 'Descripción',
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              border: OutlineInputBorder()
              )
            ),
        
            IconButton(onPressed: (){}, icon: Icon(Icons.photo)),

            ElevatedButton(
              onPressed: (){},
              child: Text("Agregar"),
            ),

             
            
          ],
          
        
        
        ),
      ),
    );
  }
}