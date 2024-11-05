import 'package:provider/provider.dart';
import 'package:proyecto/informacion/mascotas.dart';
import 'package:proyecto/informacion/modelo.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/informacion/mascotas.dart';
import 'package:proyecto/pantallas/detalles.dart';
import 'package:proyecto/providers/providers.dart';


class Perdidos extends StatefulWidget {
  const Perdidos({super.key});

  @override
  State<Perdidos> createState() => _PerdidosState();
}

class _PerdidosState extends State<Perdidos> {
  @override
  Widget build(BuildContext context) {
        final provider = Provider.of<Providers>(context);

    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        itemCount: mascotas_perdidas.length,
        itemBuilder: (context, index) {
          final mascota = mascotas_perdidas[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalleMascota(
                        mascota: mascotas_perdidas[index], 
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
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(mascota.imageUrl),
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
                              mascota.title,
                              style: TextStyle(
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
      );
  }
}