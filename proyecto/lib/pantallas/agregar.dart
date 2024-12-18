import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:proyecto/pantallas/camara.dart';
import 'package:proyecto/pantallas/principal.dart';
import 'package:proyecto/providers/providers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class Add extends StatefulWidget {
  const Add({super.key, required this.editar, required this.id});
  final int editar;
  final String id;

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final TextEditingController nombre = TextEditingController();
  final TextEditingController imagg = TextEditingController();
  @override 



  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Providers>(context, listen: false);
    productsProvider.getProducts();

    return Consumer<Providers>(
      builder: (context, productsProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Nueva mascota'),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(70, 50, 70, 40),
                child: Column(
                  children: [
                    TextField(
                      controller: nombre,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Nombre',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                    Column(
                  //   children: [
                  //     IconButton(
                  //       icon: const Icon(
                  //       Icons.image,
                  //       size: 20,
                  //        color: Colors.grey,
                  //       ),
                  //       onPressed: () {
                                           
                  //                           Navigator.push(
                  //                             context,
                  //                             MaterialPageRoute(
                  //                               builder: (context) => CameraScreen(

                  //                               ),
                  //                             ),
                  //                           );
                  //                         },
                  //                       ),
            
                   // ],
      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            final name = nombre.text;
                            final imag = imagg.text;
                            if (name != "" && imag != "") {
                              if (widget.editar == 0) {
                                productsProvider.addProduct(name, imag);
                              } else {
                                productsProvider.updateProduct(widget.id, name, imag);
                              }
                            }
                          },
                          child: const Text("Guardar"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Principal()),
                            );
                          },
                          child: const Text("Cancelar"),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
