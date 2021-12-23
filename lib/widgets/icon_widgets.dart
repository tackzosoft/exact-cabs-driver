import 'package:flutter/material.dart';

class AppBarBack extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.all(0),
      icon: Icon(
        Icons.arrow_back,
        color: Colors.white,
        size: 25,
      ),
      onPressed: ()=> Navigator.pop(context),
    );
  }
}