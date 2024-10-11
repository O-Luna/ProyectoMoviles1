import 'package:proyecto/informacion/mascotas.dart';
import 'package:proyecto/informacion/modelo.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/informacion/mascotas.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';


class DetalleMascota extends StatelessWidget {
  final Mascotas mascota; 

  const DetalleMascota({
    Key? key,
    required this.mascota,
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mascota.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen de la mascota
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Image.network(
                mascota.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Título 
                  Text(
                    mascota.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  // Descripción
                  Text(
                    mascota.descripcion,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ), 
                  Container(
                    width: 50,
                    height: 50, 
                    child: OSMViewer(
                      controller: SimpleMapController(
                        initPosition: GeoPoint(
                            latitude: 47.4358055,
                            longitude: 8.4737324,
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
                  Image.network(
                    "https://th.bing.com/th/id/R.0f074dff24f3e616903c29deac23cba7?rik=YAgjzHag3BnuKQ&riu=http%3a%2f%2fallinallnews.com%2fwp-content%2fuploads%2f2015%2f05%2fGoogle-Maps-1024x574.png&ehk=fWQ36tM5F2fQfSM1%2fTmeUa%2b%2bgbAyc6OMeSPBR9OgWy4%3d&risl=&pid=ImgRaw&r=0",
                    fit: BoxFit.cover,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [                      
                      ElevatedButton(
                        onPressed: (){},
                        child: Text("Reportar como perdido"),
                      ),
                    ],
                  ),                  
                ],
              ),
            ),
          ],
        ),
      ),
      
    );
  }
}