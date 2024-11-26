import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/providers/providers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class Config extends StatefulWidget {
  const Config({super.key});

  @override
  State<Config> createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  bool darkmode = false;
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  late Directory _photoDir;

  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<Providers>(context, listen: false).getUserPhoto();
    });
  }

  Future<void> _requestPermissions(BuildContext context) async {
    final cameraStatus = await Permission.camera.request();

    if (cameraStatus.isGranted) {
      await Provider.of<Providers>(context, listen: false).pickAndSaveImage();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permissions denied')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Providers>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Configuración"),
          ),
          body: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Activar modo oscuro",
                      style: TextStyle(fontSize: 18),
                    ),
                    Switch(
                      value: provider.isDarkMode,
                      onChanged: (value) {
                        provider.fondo();
                      },
                    ),
                  ],
                ),
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
                      child: provider.selectedImage != null
                          ? Image.file(
                              provider.selectedImage!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.account_circle,
                                  size: 200,
                                  color: Colors.grey,
                                );
                              },
                            )
                          : const Icon(
                              Icons.account_circle,
                              size: 200,
                              color: Colors.grey,
                            ),
                    ),
                  ),
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
      },
    );
  }
}
