import 'dart:ffi';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyecto/pantallas/encontrados.dart';
import 'package:proyecto/pantallas/configuracion.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class Providers with ChangeNotifier {
  bool _ActivDarkMode = false;
  bool get isDarkMode => _ActivDarkMode;

  File? _selectedImage;
  File? get selectedImage => _selectedImage;

  String? _currentImagePath;
  String? get currentImagePath => _currentImagePath;

  File? _selectedImage2;
  File? get selectedImage2 => _selectedImage2;

  // BluetoothDevice? _deviceConnected;
  // BluetoothDevice? get deviceConnected => _deviceConnected;
 

  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> get products => _products;

  List<Map<String, dynamic>> _detalles = [];
  List<Map<String, dynamic>> get detalles => _detalles;

  List<Map<String, dynamic>> _encontrados = [];
  List<Map<String, dynamic>> get encontrados =>_encontrados;

  List<Map<String, dynamic>> _perdidas = [];
  List<Map<String, dynamic>> get perdidas => _perdidas;

  List<Map<String, dynamic>> _fotos = [];
  List<Map<String, dynamic>> get fotos => _fotos;


  int _currentPageIndex=0;
  int get currentPageIndex => _currentPageIndex;
  void fondo() {
    _ActivDarkMode = !_ActivDarkMode;
    notifyListeners();
  }

  void pageindex(int index){
    _currentPageIndex = index;
    notifyListeners();
  }

   void reorderMascotas(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final item = _products.removeAt(oldIndex);
    _products.insert(newIndex, item);
    notifyListeners();
  }

  ThemeData get currentTheme => _ActivDarkMode ? _darkTheme : _lightTheme;
  final _lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: const Color.fromARGB(255, 214, 214, 214),
    ),
  );

  final _darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color.fromARGB(255, 97, 96, 96),
    ),
  );

    Future<void> getProducts() async {
    //QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Mascotas').get();
    //_products = snapshot.docs.map((doc){final data=doc.data() as Map<String, dynamic>; data['id']=doc.id;return data;}).toList();

     String? userId = FirebaseAuth.instance.currentUser?.uid;
     QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Mascotas').get();
      final querySnapshot = await FirebaseFirestore.instance.collection('Mascotas').where('userId', isEqualTo: userId).get();
         if (querySnapshot.docs.isNotEmpty) {
         _products = querySnapshot.docs.map((doc){final data=doc.data() as Map<String, dynamic>; data['id']=doc.id;return data;}).toList();
          notifyListeners();
        }
    notifyListeners();
  }

  Future<void> deleteProduct(String productId) async {
    CollectionReference products = FirebaseFirestore.instance.collection('Mascotas');
    await products.doc(productId).delete().catchError((error) { print("Failed to delete product: $error"); });
    _products.removeWhere((product) => product['id'] == productId);
    notifyListeners();
  }

  Future<void> addProduct(String name, String imag, String descipcion, ) async {
  CollectionReference products = FirebaseFirestore.instance.collection('Mascotas');
  await  products.add({
    'nombre': name,
    'imagen': imag,
    'descipcion': descipcion,
    'latitud': 4.6097100, 
    'longitud': -74.0817500,
    'estado': 'normal',
    'userId': FirebaseAuth.instance.currentUser?.uid
    

  });

  await getProducts();
  }

    Future<void> addtoken(String tk) async {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('tokens').where('token',isEqualTo: tk).get(); /**c */
      if(querySnapshot.docs.isEmpty){
        CollectionReference token = FirebaseFirestore.instance.collection('tokens');
        await  token.add({ 'token': tk, }); }

  }

  Future<void> updateProduct(String productId, String newName, String newImag,String descipcion) {
    CollectionReference products = FirebaseFirestore.instance.collection('Mascotas');
    return products.doc(productId).update({
      'nombre': newName,
      'imagen': newImag,
      'descipcion': descipcion,
      'estado': 'normal',
      
    })
      .then((value) => print("Product name updated successfully!"))
      .catchError((error) => print("Failed to update product name: $error"));
  }

 void getPerdidas() {
    FirebaseFirestore.instance.collection('Mascotas').where('estado', isEqualTo: 'perdido').snapshots().listen((snapshot) {
      _perdidas = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();
      notifyListeners();
    });
  }

  Future<void> reportarPerdido(Map<String, dynamic> mascota) async {
    try {
      await FirebaseFirestore.instance.collection('Mascotas').doc(mascota['id']).update({
        'estado': 'perdido',
      });

      notifyListeners();
    } catch (error) {
      print("Error al reportar como perdido: $error");
      rethrow;
    }
  }

  Future<void> reportarEncontrado(String mascotaId) async {
    try {
      await FirebaseFirestore.instance.collection('Mascotas').doc(mascotaId).update({
        'estado': 'encontrado',
        'fecha_encuentro': DateTime.now().toString(),
      });

      notifyListeners();
    } catch (error) {
      print("Error al reportar como encontrado: $error");
      rethrow;
    }
  }

    Future<void> reportarNormal(String mascotaId) async {
    try {
      await FirebaseFirestore.instance.collection('Mascotas').doc(mascotaId).update({
        'estado': 'normal',
        'fecha_encuentro': DateTime.now().toString(),
      });

      notifyListeners();
    } catch (error) {
      print("Error al reportar como encontrado: $error");
      rethrow;
    }
  }

   void getEncontradas() {
    FirebaseFirestore.instance.collection('Mascotas').where('estado', isEqualTo: 'encontrado').snapshots().listen((snapshot) {
      _encontrados = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();
      notifyListeners();
    });
  }

  Future<void> pickAndSaveImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
            String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (pickedFile != null && userId != null) {
        _selectedImage = File(pickedFile.path);
        
        final querySnapshot = await FirebaseFirestore.instance.collection('Fotos').where('userId', isEqualTo: userId).get();

        if(querySnapshot.docs.isNotEmpty){
        await FirebaseFirestore.instance.collection('Fotos').doc(querySnapshot.docs.first.id).update({
          'imagePath': pickedFile.path,
          'userId': FirebaseAuth.instance.currentUser?.uid,
        });}
        else {
          await FirebaseFirestore.instance.collection('Fotos').add({
            'imagePath': pickedFile.path,
            'userId': userId,
          });
        }
        _currentImagePath = pickedFile.path;
        notifyListeners();
      }
    } catch (e) {
      print("Error al guardar la imagen: $e");
      rethrow;
    }
  }

  Future<void> getUserPhoto() async {
    try {
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        final querySnapshot = await FirebaseFirestore.instance
            .collection('Fotos')
            .where('userId', isEqualTo: userId)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          _currentImagePath = querySnapshot.docs.first.get('imagePath');
          if (_currentImagePath != null) {
            _selectedImage = File(_currentImagePath!);
          }
          notifyListeners();
        }
      }
    } catch (e) {
      print("Error al obtener la foto: $e");
    }
  }
}



