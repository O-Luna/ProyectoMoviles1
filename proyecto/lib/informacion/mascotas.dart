import 'package:flutter/material.dart';
import 'package:proyecto/informacion/modelo.dart';

const infomascotas = [
 Mascotas(
  id:'c1',
  title: 'Firulais',
  imageUrl: 'https://th.bing.com/th/id/OIP.zWGv9P-DCJilSoXnXdmg8gHaE8?rs=1&pid=ImgDetMain',
  descripcion:'Perro bueno'
 
 ),
  Mascotas(
  id:'c2',
  title: 'Garfield',
  imageUrl: 'https://th.bing.com/th/id/OIP.NsTRaGJjGPEyaadS4t1kEgAAAA?rs=1&pid=ImgDetMain',
  descripcion:'Gato'
 ),
  Mascotas(
  id:'c3',
  title: 'chuchin',
  imageUrl: 'https://pbs.twimg.com/profile_images/1558412572184944641/zBuJ-lVN_400x400.jpg',
  descripcion:'Perro '
 
 )
];

const mascotas_perdidas = [
  Mascotas(
  id:'c1',
  title: 'Jose',
  imageUrl: 'https://th.bing.com/th/id/OIP.zWGv9P-DCJilSoXnXdmg8gHaE8?rs=1&pid=ImgDetMain',
  

  descripcion:'última ubicación conocida'

  
 
 ),
  Mascotas(
  id:'c2',
  title: 'Miauchis',
    imageUrl: 'https://th.bing.com/th/id/OIP.NsTRaGJjGPEyaadS4t1kEgAAAA?rs=1&pid=ImgDetMain',
  descripcion:'última ubicación conocida'

 ),
  Mascotas(
  id:'c3',
  title: 'Furcio',
 
  imageUrl: 'https://pbs.twimg.com/profile_images/1558412572184944641/zBuJ-lVN_400x400.jpg',
  descripcion:'última ubicación conocida '
 
 )
];


class Mascota {
  final String imageUrl;
  final String title;
  Mascota({required this.imageUrl, required this.title});
}