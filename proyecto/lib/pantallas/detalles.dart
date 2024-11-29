import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/pantallas/bluetooth.dart';
import 'package:proyecto/providers/providers.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

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
  late MapController mapController; 

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
      appBar: AppBar(
        title: Text(widget.mascota['nombre'] ?? 'Detalles de mascota'),
      ),
      body: Consumer<Providers>(
        builder: (context, provider, child) {
          bool estaPerdida = provider.products.any((m) => m['id'] == widget.mascota['id']);
          var detallesMascota = provider.products.firstWhere(
            (perdidas) => perdidas['nombre'] == widget.mascota['nombre'],
            orElse: () => {},
          );

          return RefreshIndicator(
            onRefresh: _refresh,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: widget.mascota['imagen'] != null
                        ? Image.file(
                            File(widget.mascota['imagen']),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.pets,
                                size: 100,
                                color: Colors.grey,
                              );
                            },
                          )
                        : const Icon(
                            Icons.pets,
                            size: 100,
                            color: Colors.grey,
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
                          detallesMascota['descipcion'] ?? 'Sin descripción',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 16),
                        
                        Center(
                          child: widget.mascota['estado'] == 'normal'
                          ?ElevatedButton(
                            onPressed: () { 
                              Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Bluetooth(
                                  mascota: detallesMascota,
                                ),
                              ),
                            );
                            provider.id_gps_blu= provider.id_gps;
                            },
                            child: Text("Configurar bluetooth"),
                          )
                          : Container()
                        ),
                        const SizedBox(height: 16),
                        if (detallesMascota['latitud'] != null) ...[
                          Text(
                            widget.mascota['estado'] == 'perdido'
                                  ? 'Última ubicación donde se encontraba'
                                  : widget.mascota['estado'] == 'encontrado'? 'Ubicación donde se encontró'
                                  : 'Ubicación',
                            //'Ubicación:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),                         
                          const SizedBox(height: 8),
                          Container(
                            width: 450,
                            height: 300,
                            child: OSMViewer(
                              controller: SimpleMapController(                                
                                initPosition: GeoPoint(
                                  //latitude: detallesMascota['latitud'],
                                  latitude: widget.mascota['latitud'],
                                  //longitude: detallesMascota['longitud'],
                                  longitude: widget.mascota['longitud'],
                                ),
                                markerHome: const MarkerIcon(
                                  icon: Icon(Icons.pets_outlined,
                                            color: Colors.red,),                                  
                                ),
                              ),
                              zoomOption: const ZoomOption(
                                initZoom: 16,
                                minZoomLevel: 11,
                              ),
                              
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              try {
                                if (widget.mascota['estado'] == 'perdido') {
                                  await Provider.of<Providers>(context, listen: false)
                                      .reportarEncontrado(widget.mascota['id']);
                                } else if (widget.mascota['estado'] == 'encontrado'){
                                  await Provider.of<Providers>(context, listen: false)
                                      .reportarNormal(widget.mascota['id']);
                                } else{
                                  await Provider.of<Providers>(context, listen: false)
                                  .reportarPerdido(widget.mascota);
                                }
                                Navigator.pop(context);
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error: ${e.toString()}')),
                                );
                              }
                            },
                            child: Text(
                              widget.mascota['estado'] == 'perdido'
                                  ? '¡Reportar como encontrada!'
                                  : widget.mascota['estado'] == 'encontrado'? '¡Encontrada!'
                                  : 'Reportar como perdido',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                 ],
              ),
            ),
          );
        },
      ),
    );
  }
}