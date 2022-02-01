import 'package:dog_app/bloc/favourites/favourites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/breeds.dart';
import 'widgets/description.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeDetailPage extends StatelessWidget {
  const HomeDetailPage({Key key, @required this.theBreed}) : super(key: key);

  final BreedsModel theBreed;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool containsBreed = false;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Text(
          theBreed.name,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: size.height * 0.04,
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
        child: BlocBuilder<FavouritesBloc, FavouritesState>(
          builder: (context, state) {
            if (state is FavouritesLoading) {
              return Icon(Icons.favorite_border_outlined);
            } else if (state is FavouritesLoaded) {
              if (state.favouritesList.favourites.contains(theBreed)) {
                containsBreed = true;
                return Icon(Icons.favorite, color: Colors.red);
              } else {
                return Icon(Icons.favorite_border_outlined);
              }
            } else if (state is FavouritesLoadingError) {
              return Icon(Icons.error_outline);
            } else {
              return Icon(Icons.error_outline);
            }
          },
        ),
        onPressed: () {
          if (containsBreed) {
            context.read<FavouritesBloc>().add(FavouritesRemoved(theBreed));

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Removed from Favourites"),
                duration: Duration(milliseconds: 900),
              ),
            );
          } else {
            context.read<FavouritesBloc>().add(FavouritesAdded(theBreed));

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
