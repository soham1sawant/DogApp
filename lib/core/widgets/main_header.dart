import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/favourites/bloc/favourites_bloc.dart';


class MainHeader extends StatelessWidget {
  final String header;
  final bool icon;

  const MainHeader({Key? key, required this.header, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;

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
                return Badge(
                  badgeContent: Text(
                    state.favouritesList.favourites.length.toString(),
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  badgeColor: Theme.of(context).focusColor,
                  position: BadgePosition.topEnd(top: 0, end: 0),
                  animationType: BadgeAnimationType.fade,
                  showBadge: state.favouritesList.favourites.isEmpty ? false : true,
                  child: IconButton(
                    icon: const Icon(Icons.favorite),
                    color: Theme.of(context).primaryColor,
                    iconSize: orientation == Orientation.portrait
                        ? size.height * 0.05
                        : size.height * 0.075,
                    onPressed: () =>
                        Navigator.of(context).pushNamed("/favourites"),
                  ),
                );
              } else {
                return const Center(child: Icon(Icons.error_outline));
              }
            },
          ),
      ],
    );
  }
}
