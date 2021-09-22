import '../../logic/favourite_breeds.dart';
import 'package:provider/provider.dart';
import '../../data/models/breeds.dart';
import '../widgets/description.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeDetailPage extends StatelessWidget {
  const HomeDetailPage({Key key, this.theBreed}) : super(key: key);

  final BreedsModel theBreed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Text(
          theBreed.name,
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Theme.of(context).canvasColor,
              child: CachedNetworkImage(
                imageUrl: theBreed.image.url,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Description(
              theBreed: theBreed,
            ),
          ),
        ],
      ),
      floatingActionButton: Consumer<FavouriteBreeds>(
        builder: (context, favouritesClass, child) {
          if (favouritesClass.favouriteBreeds.contains(theBreed)) {
            return FloatingActionButton(
              child: Icon(Icons.favorite, color: Colors.red),
              onPressed: () {
                favouritesClass.addBreed(theBreed);
              },
            );
          } else {
            return FloatingActionButton(
              child: Icon(Icons.favorite_border_outlined),
              onPressed: () {
                favouritesClass.removeBreed(theBreed);
              },
            );
          }
        },
      ),
    );
  }
}
