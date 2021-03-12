import 'package:flutter/material.dart';

import '../themes.dart';

class CatalogHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Dog App",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: MyTheme.darkBluishColor,
      ),
      textScaleFactor: 3,
    );
  }
}
