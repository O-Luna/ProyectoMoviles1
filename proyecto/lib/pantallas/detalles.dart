import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/providers/providers.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class Detalles extends StatefulWidget {
  final Map<String, dynamic> mascota;

  const Detalles({
    Key? key,
    required this.mascota,
  }) : super(key: key);

  @override
  State<Detalles> createState() => _DetallesState();
}

class _DetallesState extends State<Detalles> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mascota['nombre'] ?? 'Detalles de mascota'),
      ),
      body: Consumer<Providers>(
        builder: (context, provider, child) {/*Buscar en la lista un animal que tenga el mismo nombre*/ 
        bool estaPerdida = provider.Perdidos.any((m) => m['id'] == widget.mascota['id']);/**verificar si hay algun detalle que cumple la condición    */
          /* True si si se encuentra un elemento igual*/
          final detallesMascota = provider.Perdidos.firstWhere(
            (perdidas) => perdidas['nombre'] == widget.mascota['nombre'],
            orElse: () => {}, /* Si no hay descripción del animal se devuelve un mapa vacio(evitar errores)*/
          );
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: Image.network(
                    widget.mascota['imagen'] ?? 'https://via.placeholder.com/300',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.mascota['nombre'] ?? 'Sin nombre',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        detallesMascota['descripcion'] ?? 'Sin descripción',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16),
                      if (detallesMascota['ubicacion'] != null) ...[
                        const Text('Ubicación:',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          detallesMascota['ubicacion'],
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 450,
                          height:300, 
                    child: OSMViewer(
                      controller: SimpleMapController(
                        initPosition: GeoPoint(
                         latitude:  detallesMascota['latitude'],
                            //latitude: 47.4358055,
                           // longitude: 8.4737324,
                           longitude: detallesMascota['longitude']
                        ),
                      markerHome: const MarkerIcon(
                          icon: Icon(Icons.home),
                        ),
                      ),
                      zoomOption: const ZoomOption(
                      initZoom: 16,
                      minZoomLevel: 11,
                      )
                    ),
                  ),
                    const SizedBox(height: 8),
                      ],
                      Center(
                        child: ElevatedButton(
                          onPressed: () async{
                            if(estaPerdida){
                              await provider.reportarEncontrado(widget.mascota["id"]);
                            }else{
                               Map<String, dynamic> mascotaData = {
                                'nombre': widget.mascota['nombre'],
                                'imagen': widget.mascota['imagen'],
                                'descripcion': 'Mascota reportada como perdida',
                               // 'ubicacion': 'Última ubicación vista', 
                               //  'latitude' :,
                               //  'longitude':,
                              };
                                await provider.Perdido(mascotaData);
                            }
                          },
                          child: 
                          Text(
                            estaPerdida ? '¡Mascota Encontrada!' : 'Reportar como Perdido',                           
                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
