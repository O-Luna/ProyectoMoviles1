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
 class _ConfigState  extends State<Config> {
   bool darkmode=false;
   final ImagePicker _picker = ImagePicker();
   File? _selectedImage;
   late Directory _photoDir;

   @override
   void initState() {
     super.initState();
     _initPhotoDir();
   }

   Future<void> _initPhotoDir() async {
     final directory = await getApplicationDocumentsDirectory();
     _photoDir = Directory('${directory.path}/MyPhotos');
     if (!(await _photoDir.exists())) {
       await _photoDir.create();
     }
   }

   Future<void> _requestPermissions() async {
     final cameraStatus = await Permission.camera.request();

     if (cameraStatus.isGranted) {
       await _pickImageFromGallery();
     } else {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Permissions denied')),
       );
     }
   }

   Future<void> _pickImageFromGallery() async {
     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
     if (pickedFile != null) {
       setState(() {
         _selectedImage = File(pickedFile.path);
       });
     }
   }

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
               if (_selectedImage != null)
                 Image.file(_selectedImage!, fit: BoxFit.cover, height: 200),
               IconButton(
               onPressed: _requestPermissions,
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
