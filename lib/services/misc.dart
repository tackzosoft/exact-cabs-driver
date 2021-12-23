import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

bool isNumeric(String text){
  if (text == null) {
    return false;
  }
  return double.tryParse(text) != null;
}
