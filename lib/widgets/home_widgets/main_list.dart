import 'package:flutter/material.dart';
import 'package:dog_app/models/breeds.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
          child: Container(
            height: 50.0,
            width: 200.0,
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: breed.image.url,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
