import 'package:flutter/material.dart';
import 'package:exact_cabs_driver/utils/colors.dart';

class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  MainButton({@required this.text, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: BoxDecoration(
          color: darkBlueGrey,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
      ),
    );
  }
}


class FilledButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;
  final Color color;
  FilledButton({@required this.icon, @required this.onPressed, @required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: icon,
      ),
    );
  }
}

class BorderedButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  BorderedButton({@required this.color, @required this.text, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            text.toUpperCase(),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 18,

            ),
          ),
        ),
      ),
    );
  }
}
