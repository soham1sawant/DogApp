import '../pages/favourites_page.dart';
import 'package:flutter/material.dart';

class MainHeader extends StatelessWidget {
  final header;
  final icon;

  const MainHeader({Key key, @required this.header, @required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          header,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).accentColor,
          ),
          textScaleFactor: 3,
        ),
        if (icon)
          IconButton(
            icon: Icon(Icons.favorite),
            color: Theme.of(context).accentColor,
            iconSize: 30.0,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FavouritesPage(),
              ),
            ),
          ),
      ],
    );
  }
}
