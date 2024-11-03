import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/informacion/mascotas.dart';
import 'package:proyecto/informacion/modelo.dart';
import 'package:proyecto/pantallas/agregar.dart';
import 'package:proyecto/pantallas/configuracion.dart';
import 'package:proyecto/pantallas/detalles.dart';
import 'package:proyecto/pantallas/perdidos.dart';
import 'package:proyecto/providers/providers.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  var currentPageIndex = 0;
  //List<Mascotas> mascotasList = List.from(infomascotas); 
  
 //color: provider.isDarkMode ? Colors.grey: Colors.white,
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Providers>(context);
    return Scaffold(
      body: ReorderableListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          for (int index = 0; index < provider.mascotasList.length; index++)    
          Container( 
            key: ValueKey(provider.mascotasList[index]),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalleMascota(
                        mascota: provider.mascotasList[index], 
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: provider.isDarkMode ? Colors.grey: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 110,
                        height: 115,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(provider.mascotasList[index].imageUrl),
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
                                provider.mascotasList[index].title,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                                color: Colors.grey,
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
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
          provider.reorderMascotas(oldIndex, newIndex);
          }
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Agregar()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
