import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/pantallas/detalles.dart';
import 'package:proyecto/providers/providers.dart';

class Encontrados extends StatefulWidget {
  const Encontrados({super.key});

  @override
  State<Encontrados> createState() => _EncontradosState();
}

class _EncontradosState extends State<Encontrados> {
    Future<void>_refresh()  async{
     final provider = Provider.of<Providers>(context, listen: false);
    await provider.getProducts();
    provider.getEncontradas();
  }
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<Providers>(context, listen: false);
    provider.getProducts();
    provider.getEncontradas();
  }

  @override
  
  Widget build(BuildContext context) {
    return Consumer<Providers>(
      builder: (context, provider, child) {
        final mascotasencontradas = provider.encontrados;

        if (mascotasencontradas.isEmpty) {
          return const Center(
            child: Text(
              'No hay mascotas encontradas',
              style: TextStyle(fontSize: 18),
            ),
          );
        }
        
 return RefreshIndicator(
          onRefresh: _refresh,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            itemCount: mascotasencontradas.length,
            itemBuilder: (context, index) {
              final mascota = mascotasencontradas[index];
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
                      color: provider.isDarkMode ? Colors.grey[800] : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 110,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                mascota['imagen'] ?? 
                                'https://via.placeholder.com/110x120'
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  mascota['nombre'] ?? 'Sin nombre',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: provider.isDarkMode ? 
                                      Colors.white : Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),
                        
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.chevron_right,
                            color: provider.isDarkMode ? 
                              Colors.white70 : Colors.black54,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Detalles(
                                  mascota: mascota,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}