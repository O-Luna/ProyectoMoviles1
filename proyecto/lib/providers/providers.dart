import 'package:flutter/material.dart';
import 'package:proyecto/informacion/mascotas.dart';
import 'package:proyecto/informacion/modelo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Providers with ChangeNotifier {
  bool _ActivDarkMode = false;
  bool get isDarkMode => _ActivDarkMode;

  List<Mascotas> _mascotasList = List.from(infomascotas);
  List<Mascotas> get mascotasList => _mascotasList;

  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> get products => _products;

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
    final item = _mascotasList.removeAt(oldIndex);
    _mascotasList.insert(newIndex, item);
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
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Tus_Mascotas').get();
    _products = snapshot.docs.map((doc){final data=doc.data() as Map<String, dynamic>; data['id']=doc.id;return data;}).toList();
    notifyListeners();
  }


  Future<void> deleteProduct(String productId) async {
  
    CollectionReference products = FirebaseFirestore.instance.collection('Tus_Mascotas');
    await products.doc(productId).delete().catchError((error) { print("Failed to delete product: $error"); });
    _products.removeWhere((product) => product['id'] == productId);
    notifyListeners();
  }

  Future<void> addProduct(String name, String imag) async {
  CollectionReference products = FirebaseFirestore.instance.collection('Tus_Mascotas');
  await  products.add({
    'nombre': name,
    'imagen': imag,
    
  });
  await getProducts();
 
  }

  Future<void> updateProduct(String productId, String newName, String newImag) {
    CollectionReference products = FirebaseFirestore.instance.collection('Tus_Mascotas');
    
    return products.doc(productId).update({
      'name': newName,
      'imagen': newImag,
      
    })
      .then((value) => print("Product name updated successfully!"))
      .catchError((error) => print("Failed to update product name: $error"));
  }
}

