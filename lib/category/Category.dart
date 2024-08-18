import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Category {
  String id;
  String name;
  String imagePath;
  Color backgroundColor;

  Category(
      {required this.id,
      required this.name,
      required this.imagePath,
      required this.backgroundColor});
}
