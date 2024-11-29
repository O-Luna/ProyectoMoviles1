import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto/pantallas/agregar.dart';
import 'package:proyecto/pantallas/detalles.dart';
import 'package:proyecto/providers/providers.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  Future<void>_refresh() async {
    await Provider.of<Providers>(context, listen: false).getProducts();    
    final fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken != null) {
      Provider.of<Providers>(context, listen: false).addtoken(fcmToken);
    }
  }

  @override
  void initState() {
    super.initState();
    Provider.of<Providers>(context, listen: false).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<Providers>(
        builder: (context, provider, child) {
          return RefreshIndicator(
            onRefresh: _refresh,
            child: ReorderableListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              children: [
                for (int index = 0; index < provider.products.length; index++)
                  Container(
                    key: ValueKey(provider.products[index]['id']),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Detalles(
                                mascota: provider.products[index],
                              ),
                            ),
                          );
                          provider.id_gps= provider.products[index]['id'];
                        },
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                            color: provider.isDarkMode ? Colors.grey : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 110,
                                height: 115,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  ),
                                  child: provider.products[index]['imagen'] != null
                                      ? Image.file(
                                          File(provider.products[index]['imagen']),
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return const Icon(
                                              Icons.pets,
                                              size: 50,
                                              color: Colors.grey,
                                            );
                                          },
                                        )
                                      : const Icon(
                                          Icons.pets,
                                          size: 50,
                                          color: Colors.grey,
                                        ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        provider.products[index]['nombre'] ?? 'Sin nombre',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(provider.products[index]['estado'] == 'normal' ? Icons.sentiment_satisfied_alt: provider.products[index]['estado'] == 'perdido' ? Icons.sentiment_dissatisfied_sharp:
                                          Icons.sentiment_neutral,
                                          color: provider.products[index]['estado'] == 'normal' ? Colors.green : provider.products[index]['estado'] == 'perdido' ? Colors.red : Colors.yellow,),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.edit,
                                              size: 20,
                                              color: Colors.grey,
                                            ),
                                            onPressed: () {
                                              _refresh();
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => Add(
                                                    editar: 1,
                                                    id: provider.products[index]['id'],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.delete,
                                              size: 20,
                                              color: Colors.grey,
                                            ),
                                            onPressed: () {
                                              provider.deleteProduct(provider.products[index]['id']);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
              ],
              onReorder: (int oldIndex, int newIndex) async {
                if (newIndex > oldIndex) {
                  newIndex -= 1;
                }    
                final CollectionReference mascotas = 
                FirebaseFirestore.instance.collection('Mascotas');

                final item = provider.products.removeAt(oldIndex);
                provider.products.insert(newIndex, item);
                provider.notifyListeners();
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _refresh();
          final fcmToken = await FirebaseMessaging.instance.getToken();
          print("Token conseguido y copiado al portapapeles: ${fcmToken}");
          await Clipboard.setData(ClipboardData(text: "$fcmToken"));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Add(editar: 0, id: "0")),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}