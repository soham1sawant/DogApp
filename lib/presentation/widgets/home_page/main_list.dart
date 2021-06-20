import 'package:dog_app/presentation/pages/home_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:dog_app/models/breeds.dart';

class MainList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: BreedsList.items.length,
      itemBuilder: (context, index) {
        final breed = BreedsList.items[index];
        return InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeDetailPage(
                        theBreed: breed,
                      ))),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              breed.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        );
      },
    );
  }
}
