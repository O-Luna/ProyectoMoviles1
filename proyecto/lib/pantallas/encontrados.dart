import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/providers/providers.dart';
import 'package:proyecto/pantallas/detalles.dart';

class Encontrados extends StatefulWidget {
  const Encontrados({super.key});

  @override
  State<Encontrados> createState() => _EncontradosState();
}

class _EncontradosState extends State<Encontrados> {
    Future<void>_refresh()  async{
     await Provider.of<Providers>(context, listen: false).getEncontrados();
  }
  @override
  void initState() {
    super.initState();
    Provider.of<Providers>(context, listen: false).getEncontrados();
  }

  @override
  
  Widget build(BuildContext context) {
    return Consumer<Providers>(
      builder: (context, provider, child) {
        
        return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          itemCount: provider.detalles.length,
          itemBuilder: (context, index) {
            final mascota = provider.detalles[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Detalles(
                        mascota: mascota,
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
                            image: NetworkImage(mascota['imagen'] ?? 'https://via.placeholder.com/110x115'),
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
                                mascota['nombre'] ?? 'Sin nombre',
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
                                            Icons.delete,
                                            size: 20,
                                            color: Colors.grey,
                                          ),
                                          onPressed: () {
                                            provider.deleteEncontrados(mascota['id']);
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
            );
          },
            )
        );
      },
    );
  }
}