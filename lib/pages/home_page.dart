import 'package:dog_app/widgets/home_widgets/catalog_header.dart';
import 'package:dog_app/widgets/themes.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.creamColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CatalogHeader(),
            ],
          ),
        ),
      ),
    );
  }
}
