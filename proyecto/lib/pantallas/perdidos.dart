import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/pantallas/detalles.dart';
import 'package:proyecto/providers/providers.dart';

class Perdidos extends StatefulWidget {
  const Perdidos({super.key});

  @override
  State<Perdidos> createState() => _PerdidosState();
}

class _PerdidosState extends State<Perdidos> {
    Future<void>_refresh()  async{
     final provider = Provider.of<Providers>(context, listen: false);
    await provider.getProducts();
    provider.getPerdidas();
  }
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<Providers>(context, listen: false);
    provider.getProducts();
    provider.getPerdidas();
  }

  @override
  
  Widget build(BuildContext context) {
    return Consumer<Providers>(
      builder: (context, provider, child) {
        final mascotasPerdidas = provider.perdidas;

        if (mascotasPerdidas.isEmpty) {
          return const Center(
            child: Text(
              'No hay mascotas perdidas',
              style: TextStyle(fontSize: 18),
            ),
          );
        }
        
 return RefreshIndicator(
          onRefresh: _refresh,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            itemCount: mascotasPerdidas.length,
            itemBuilder: (context, index) {
              final mascota = mascotasPerdidas[index];
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