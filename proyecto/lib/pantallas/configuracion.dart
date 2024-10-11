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
      color: checked ? Colors.grey: Colors.green,
      child: Center(
      child: CheckboxListTile(
      tileColor: Colors.red,
      title: const Text('CheckboxListTile with red background'),
      value: checked,
      onChanged:(bool? value) { 
        setState(() {
          checked=value ??false;
        });
      },
    ),
  ),
),

    );
  }
}
