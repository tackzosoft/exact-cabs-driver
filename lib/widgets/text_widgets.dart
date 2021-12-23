import 'package:exact_cabs_driver/utils/colors.dart';
import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  final String title;
  AppBarTitle({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18
      ),
    );
  }
}

class FadedHeading extends StatelessWidget {
  final String title;
  final bool isBold;
  final double textSize;
  FadedHeading({@required this.title, this.isBold, this.textSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      isBold==null || isBold ? title.toUpperCase() : title,
      style: TextStyle(
        color: lightGreyAccent,
        fontSize:textSize?? 15,
      ),
    );
  }
}

class BoldHeading extends StatelessWidget {
  final String title;
  final bool isBold;
  BoldHeading({@required this.title, this.isBold});

  @override
  Widget build(BuildContext context) {
    return Text(
      isBold==null || isBold ? title.toUpperCase() : title,
      style: TextStyle(
        color: darkBlueGrey,
        fontSize: 18,
      ),
    );
  }
}

class ButtonText extends StatelessWidget {
  final String text;
  ButtonText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(
        color: darkBlueGrey,
        fontSize: 18,
        fontWeight: FontWeight.bold
      ),
    );
  }
}

Widget whiteText(String text){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20.0),
    child: Text(
      text.toUpperCase(),
      style: TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.bold
      ),
    ),
  );
}






