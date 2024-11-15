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
     await Provider.of<Providers>(context, listen: false).getProducts3();
  }
  @override
  void initState() {
    super.initState();
    Provider.of<Providers>(context, listen: false).getProducts2();
  }

  @override
  
  Widget build(BuildContext context) {
    return Consumer<Providers>(
      builder: (context, provider, child) {
        
        return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          itemCount: provider.perdidas.length,
          itemBuilder: (context, index) {
            final mascota = provider.perdidas[index];
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