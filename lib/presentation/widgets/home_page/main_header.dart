import 'package:flutter/material.dart';
class MainHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Dog App",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).accentColor,
      ),
      textScaleFactor: 3,
    );
  }
}
