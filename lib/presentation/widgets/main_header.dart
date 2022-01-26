import 'package:flutter/material.dart';

class MainHeader extends StatelessWidget {
  final header;
  final icon;

  const MainHeader({Key key, @required this.header, @required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          header,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
          textScaleFactor: size.height * 0.0045,
        ),
        if (icon)
          IconButton(
            icon: Icon(Icons.favorite),
            color: Theme.of(context).primaryColor,
            iconSize: size.height * 0.05,
            onPressed: () => Navigator.of(context).pushNamed("/favourites"),
          ),
      ],
    );
  }
}
