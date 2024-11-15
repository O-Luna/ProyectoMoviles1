import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto/pantallas/encontrados.dart';
import 'package:proyecto/pantallas/perdidos.dart';

class Providers with ChangeNotifier {
  bool _ActivDarkMode = false;
  bool get isDarkMode => _ActivDarkMode;

  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> get products => _products;

  List<Map<String, dynamic>> _detalles = [];
  List<Map<String, dynamic>> get detalles => _detalles;

  List<Map<String, dynamic>> _perdidos = [];
  List<Map<String, dynamic>> get Perdidos => _perdidos;

  List<Map<String, dynamic>> _perdidas = [];
  List<Map<String, dynamic>> get perdidas => _perdidas;

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
    Future<void> addtoken(String tk) async {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('tokens').where('token',isEqualTo: tk).get(); /**c */
      if(querySnapshot.docs.isEmpty){
        CollectionReference token = FirebaseFirestore.instance.collection('tokens');
        await  token.add({ 'token': tk, }); }

  }

  Future<void> updateProduct(String productId, String newName, String newImag) {
    CollectionReference products = FirebaseFirestore.instance.collection('Tus_Mascotas');
    return products.doc(productId).update({
      'nombre': newName,
      'imagen': newImag,
      
    })
      .then((value) => print("Product name updated successfully!"))
      .catchError((error) => print("Failed to update product name: $error"));
  }

Future<void> getProducts2() async {
  FirebaseFirestore.instance
    .collection('Detalles')
    .snapshots()
    .listen((snapshot) {_detalles = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();
      notifyListeners();
    });
}
Future<void> getperdidos() async {
  FirebaseFirestore.instance
    .collection('perdidos')
    .snapshots()
    .listen((snapshot) {_perdidas = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();
      notifyListeners();
    });
}

  Future<void> deleteProduct2(String productId) async {
    CollectionReference products = FirebaseFirestore.instance.collection('Detalles');
    await products.doc(productId).delete().catchError((error) { print("Failed to delete product: $error"); });
    _products.removeWhere((product) => product['id'] == productId);
    notifyListeners();
  }

  Future<void> addProduct2(String name, String imag, String description,String ubi) async {
  CollectionReference products = FirebaseFirestore.instance.collection('Detalles');
  await  products.add({
    'descripcion': description,
    'imagen': imag,
    'nombre': name,
    'ubicacion': ubi,
    
  });
  }
  Future<void> updateProduct2(String productId, String newName, String newImag) {
    CollectionReference products = FirebaseFirestore.instance.collection('Detalles');
    
    return products.doc(productId).update({
      'nombre': newName,
      'imagen': newImag,
      
    })
      .then((value) => print("Product name updated successfully!"))
      .catchError((error) => print("Failed to update product name: $error"));
  }


  Future<void> Perdido(Map<String, dynamic> mascota) async {
    try {
      CollectionReference detalles = FirebaseFirestore.instance.collection('Detalles');
      /**Asignarle los valores y agregar unos nuevos también  */
      await detalles.add({
        'nombre': mascota['nombre'],
        'imagen': mascota['imagen'],
        'descripcion': mascota['descripcion'] ?? 'Sin descripción',
        'ubicacion': mascota['ubicacion'] ?? 'Ubicación no especificada',
        'estado': 'perdido',
        'fecha_reporte': DateTime.now().toString(),/**Así bien perrón */
      });

      await getProducts2();
      
    } catch (error) {
      print("Error al reportar mascota perdida: $error");
      rethrow;
    }
  }

  
Future<void> reportarEncontrado(String mascotaId) async {
  try {
    final doc = await FirebaseFirestore.instance.collection('Detalles').doc(mascotaId).get();
    await FirebaseFirestore.instance.collection('Encontrados').add({
      ...doc.data()!,
      'fecha_encuentro': DateTime.now().toString(),
    });
    await doc.reference.delete();
  } catch (error) {
    print("Error al reportar mascota encontrada: $error");
    rethrow;
  }
}


  Future<void> getProducts3() async {//para perdidos obtener el id y eso
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Detalles')
          .where('estado', isEqualTo: 'perdido')
          .get();
          
      _detalles = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();
      
      notifyListeners();
    } catch (error) {
      print("Error al obtener mascotas perdidas: $error");
      _detalles = [];
      notifyListeners();
    }
  }

  Future<void> deleteProduct3(String productId) async {
    CollectionReference products = FirebaseFirestore.instance.collection('Tus_Mascotas');
    await products.doc(productId).delete().catchError((error) { print("Failed to delete product: $error"); });
    _products.removeWhere((product) => product['id'] == productId);
    notifyListeners();
  }

   Future<void> deleteEncontrados(String productId) async {
    await FirebaseFirestore.instance.collection('Encontrados').doc(productId).delete();
    _detalles.removeWhere((product) => product['id'] == productId);
    notifyListeners();
  }

Future<void> getEncontrados() async {
  try {
    FirebaseFirestore.instance.collection('Encontrados').snapshots().listen((snapshot) {
      _detalles = snapshot.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList();
      notifyListeners();
    });
  } catch (error) {
    print("Error al obtener encontrados: $error");
    _detalles = [];
    notifyListeners();
  }
  }
}