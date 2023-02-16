import 'package:dog_app/features/favourites/ui/widgets/badge_icon.dart';
import 'package:dog_app/features/favourites/bloc/favourites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainHeader extends StatelessWidget {

  const MainHeader({super.key, required this.header, required this.icon});
  final String header;
  final bool icon;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          header,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
          textScaleFactor: orientation == Orientation.portrait
              ? size.height * 0.0045
              : size.height * 0.007,
        ),
        if (icon)
          BlocBuilder<FavouritesBloc, FavouritesState>(
            builder: (context, state) {
              if (state is FavouritesLoaded) {
                return BadgeIcon(list: state.favouritesList.favourites);
              } else if (state is FavouritesLoadingError) {
                return const Center(child: Icon(Icons.error_outline));
              } else {
                return const Center(child: Icon(Icons.error_outline));
              }
            },
          ),
      ],
    );
  }
}
