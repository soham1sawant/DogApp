import '../../../features/dog_data/models/breeds.dart';
import '../../../features/favourite_breeds/viewmodel/favourite_breeds_viewmodel.dart';
import 'package:provider/provider.dart';
import 'widgets/description.dart';
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
            color: Theme.of(context).primaryColor,
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: (Provider.of<FavouriteBreeds>(context)
                .favouriteBreeds
                .contains(theBreed))
            ? Icon(Icons.favorite, color: Colors.red)
            : Icon(Icons.favorite_border_outlined),
        onPressed: () {
          if (Provider.of<FavouriteBreeds>(context, listen: false)
              .favouriteBreeds
              .contains(theBreed)) {
            Provider.of<FavouriteBreeds>(context, listen: false)
                .removeBreed(theBreed);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Removed from Favourites"),
                duration: Duration(milliseconds: 900),
              ),
            );
          } else {
            Provider.of<FavouriteBreeds>(context, listen: false)
                .addBreed(theBreed);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Added to Favourites"),
                duration: Duration(milliseconds: 900),
              ),
            );
          }
        },
      ),
    );
  }
}
