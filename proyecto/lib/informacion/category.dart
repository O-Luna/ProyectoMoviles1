import 'package:flutter/material.dart';

class Category { // Se estructura el modelo de que es una categoría en mi app MC04
  const Category({
    required this.id,
    required this.title,
    required this.image,

  });

  final String id;
  final String title;
  final String image;
}