import 'package:flutter/cupertino.dart';

class CategoryDM {
  String id;
  String name;
  IconData icon;
  String? imagePath;

  CategoryDM({
    required this.id,
    required this.name,
    required this.icon,
     this.imagePath,
  });
}