import 'package:dog_app/bloc/favourite_breeds/favouritebreeds_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/breeds.dart';
import 'widgets/description.dart';
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
        child: BlocBuilder<FavouriteBreedsBloc, FavouriteBreedsState>(
          builder: (context, state) {
            if (state.favouriteBreeds.contains(theBreed)) {
              return Icon(Icons.favorite, color: Colors.red);
            } else {
              return Icon(Icons.favorite_border_outlined);
            }
          },
        ),
        onPressed: () {
          if (BlocProvider.of<FavouriteBreedsBloc>(context)
              .state
              .favouriteBreeds
              .contains(theBreed)) {
            BlocProvider.of<FavouriteBreedsBloc>(context)
                .state
                .favouriteBreeds
                .remove(theBreed);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Removed from Favourites"),
                duration: Duration(seconds: 1),
              ),
            );
          } else {
            BlocProvider.of<FavouriteBreedsBloc>(context)
                .state
                .favouriteBreeds
                .add(theBreed);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Added to Favourites"),
                duration: Duration(seconds: 1),
              ),
            );
          }
        },
      ),
    );
  }
}
