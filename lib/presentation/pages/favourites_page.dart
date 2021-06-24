import 'package:dog_app/presentation/widgets/main_header.dart';
import 'package:flutter/material.dart';

class FavouritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(29),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainHeader(header: "Favourites", icon: false),
            ],
          ),
        ),
      ),
    );
  }
}
