import 'package:dog_app/bloc/favourites/favourites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/breeds.dart';
import 'widgets/description.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeDetailPage extends StatelessWidget {

  final BreedsModel theBreed;

  const HomeDetailPage({Key? key, required this.theBreed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
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
            fontSize: orientation == Orientation.portrait
                ? size.height * 0.04
                : size.height * 0.06,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
      ),
      body: VerticalView(theBreed: theBreed),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: BlocBuilder<FavouritesBloc, FavouritesState>(
          builder: (context, state) {
            if (state is FavouritesLoading) {
              return const Icon(Icons.favorite_border_outlined);
            } else if (state is FavouritesLoaded) {
              if (state.favouritesList.favourites.contains(theBreed)) {
                containsBreed = true;
                return const Icon(Icons.favorite, color: Colors.red);
              } else {
                return const Icon(Icons.favorite_border_outlined);
              }
            } else if (state is FavouritesLoadingError) {
              return const Icon(Icons.error_outline);
            } else {
              return const Icon(Icons.error_outline);
            }
          },
        ),
        onPressed: () {
          if (containsBreed) {
            context.read<FavouritesBloc>().add(FavouritesRemoved(theBreed));

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Removed from Favourites"),
                duration: Duration(milliseconds: 900),
              ),
            );
          } else {
            context.read<FavouritesBloc>().add(FavouritesAdded(theBreed));

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
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

class VerticalView extends StatelessWidget {
  const VerticalView({
    Key? key,
    required this.theBreed,
  }) : super(key: key);

  final BreedsModel theBreed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            color: Theme.of(context).canvasColor,
            child: CachedNetworkImage(
              imageUrl: theBreed.image.url,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
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
    );
  }
}