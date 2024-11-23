import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/pantallas/inicio.dart';
import 'package:proyecto/pantallas/principal.dart';
import 'package:proyecto/providers/providers.dart';
import 'package:image_picker/image_picker.dart';
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
  
  final TextEditingController desc = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  Future<void> _requestPermissions(BuildContext context) async {
    final cameraStatus = await Permission.camera.request();

    if (cameraStatus.isGranted) {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permisos denegados')),
      );
    }
  }

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
                    Padding(
                    padding: const EdgeInsets.fromLTRB(70, 5, 70, 30),
                    ),
                     TextField(
                      controller: desc,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Descripción',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => _requestPermissions(context),
                      child: ClipOval(
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            shape: BoxShape.circle,
                          ),
                          child: _selectedImage != null
                              ? Image.file(
                                  _selectedImage!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.pets,
                                      size: 200,
                                      color: Colors.grey,
                                    );
                                  },
                                )
                              : const Icon(
                                  Icons.pets,
                                  size: 200,
                                  color: Colors.grey,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            final name = nombre.text;
                            final descripcion = desc.text;
                            if (name != "" && _selectedImage != null) {
                              if (widget.editar == 0) {
                                productsProvider.addProduct(name, _selectedImage!.path,descripcion);
                              } else {
                                productsProvider.updateProduct(widget.id, name, _selectedImage!.path,descripcion);
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Inicio()),
                              );
                            }
                          },
                          child: const Text("Guardar"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Inicio()),
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