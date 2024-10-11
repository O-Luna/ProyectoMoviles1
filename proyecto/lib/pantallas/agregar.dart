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
    return Column(
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
        
      ],
      


    );
  }
}