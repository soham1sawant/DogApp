import 'package:cached_network_image/cached_network_image.dart';
import 'package:dog_app/core/widgets/description.dart';
import 'package:dog_app/features/favourites/bloc/favourites_bloc.dart';
import 'package:dogbreeds_api/dogbreeds_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeDetailPage extends StatelessWidget {
  const HomeDetailPage({super.key, required this.theBreed});
  final BreedsModel theBreed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var containsBreed = false;

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
                return const Icon(
                  Icons.favorite,
                  key: Key('liked_heart'),
                  color: Colors.red,
                );
              } else {
                return const Icon(
                  Icons.favorite_border_outlined,
                  key: Key('unliked_heart'),
                );
              }
            } else if (state is FavouritesLoadingError) {
              return const Icon(
                Icons.error_outline,
                key: Key('FAB_error_outline'),
              );
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
                content: Text('Removed from Favourites'),
                duration: Duration(milliseconds: 900),
              ),
            );
          } else {
            context.read<FavouritesBloc>().add(FavouritesAdded(theBreed));

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Added to Favourites'),
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
    super.key,
    required this.theBreed,
  });

  final BreedsModel theBreed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: ColoredBox(
            color: Theme.of(context).canvasColor,
            child: CachedNetworkImage(imageUrl: theBreed.image.url),
          ),
        ),
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            child: Description(
              theBreed: theBreed,
            ),
          ),
        ),
      ],
    );
  }
}
