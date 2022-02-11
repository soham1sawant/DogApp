import 'package:flutter/material.dart';

class MainHeader extends StatelessWidget {
  final header;
  final icon;

  const MainHeader({Key? key, required this.header, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          header,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
          textScaleFactor: orientation == Orientation.portrait
              ? size.height * 0.0045
              : size.height * 0.007,
        ),
        if (icon)
          IconButton(
            icon: const Icon(Icons.favorite),
            color: Theme.of(context).primaryColor,
            iconSize: orientation == Orientation.portrait
                ? size.height * 0.05
                : size.height * 0.075,
            onPressed: () => Navigator.of(context).pushNamed("/favourites"),
          ),
      ],
    );
  }
}
