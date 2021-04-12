import 'package:flutter/material.dart';

class ToDo extends ChangeNotifier {
  String? id;
  String? title;
  String? description;

  ToDo({
    this.id,
    this.description,
    this.title,
  });
}
