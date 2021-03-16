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
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  breed.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 100,
                      child: CachedNetworkImage(
                        imageUrl: breed.image.url,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    Icon(Icons.favorite_border)
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
