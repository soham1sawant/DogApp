import 'package:dog_app/logic/bloc/favourite_button/favouritebutton_cubit.dart';
import 'package:dog_app/presentation/pages/favourites_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            color: Theme.of(context).accentColor,
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
        child: BlocBuilder<FavouriteButtonCubit, FavouriteButtonState>(
          builder: (context, state) {
            if (FavouritesPage.likedList.contains(theBreed)) {
              context
                  .read<FavouriteButtonCubit>()
                  .emit(FavouriteButtonPressed());
            }
            if (state is FavouriteButtonPressed) {
              return Icon(Icons.favorite, color: Colors.red);
            } else if (state is FavouriteButtonDepressed) {
              return Icon(Icons.favorite_border_outlined);
            } else {
              return Icon(Icons.error_sharp);
            }
          },
        ),
        onPressed: () {
          if (context.read<FavouriteButtonCubit>().state == FavouriteButtonPressed()) {
            FavouritesPage.likedList.remove(theBreed);
            context.read<FavouriteButtonCubit>().removeFromFavourites();
            print(FavouritesPage.likedList);
          } else if (context.read<FavouriteButtonCubit>().state == FavouriteButtonDepressed()) {
            FavouritesPage.likedList.add(theBreed);
            context.read<FavouriteButtonCubit>().addToFavourites();
            print(FavouritesPage.likedList);
          }
        },
      ),
    );
  }
}
