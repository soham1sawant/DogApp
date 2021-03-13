import 'package:flutter/material.dart';
import 'package:dog_app/models/breeds.dart';

class MainList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: BreedsList.items.length,
      itemBuilder: (context, index) {
        final breed = BreedsList.items[index];
        return InkWell(
          onTap: () {},
          child: ,
        );
      },
    );
  }
}
