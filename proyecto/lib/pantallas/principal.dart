import 'package:flutter/material.dart';
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

  Future<void>_refresh()  async{
     await Provider.of<Providers>(context, listen: false).getProducts();
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
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(provider.products[index]['imagen'] ?? 
                                    'https://via.placeholder.com/110x115'),
                                  fit: BoxFit.cover,
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
                                        IconButton(
                                          icon: const Icon(
                                            Icons.edit,
                                            size: 20,
                                            color: Colors.grey,
                                          ),
                                          onPressed: () {
                                           
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
              FirebaseFirestore.instance.collection('Tus_Mascotas');

              final item = provider.products.removeAt(oldIndex);
              provider.products.insert(newIndex, item);
              provider.notifyListeners();
            },
            )
          );
        },
      
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
