import 'package:badges/badges.dart' as badges;
import 'package:dog_app/features/favourites/ui/favourites_page.dart';
import 'package:dogbreeds_api/dogbreeds_api.dart';
import 'package:flutter/material.dart';

class BadgeIcon extends StatelessWidget {
  const BadgeIcon({super.key, required this.list});

  final List<BreedsModel> list;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    return badges.Badge(
      badgeContent: Text(
        list.length.toString(),
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      badgeStyle: badges.BadgeStyle(
        badgeColor: Theme.of(context).focusColor,
      ),
      position: badges.BadgePosition.topEnd(top: 0, end: 0),
      badgeAnimation: const badges.BadgeAnimation.fade(),
      showBadge: list.isNotEmpty,
      child: IconButton(
        key: const Key('to-favourites-page'),
        icon: const Icon(Icons.favorite),
        color: Theme.of(context).primaryColor,
        iconSize: orientation == Orientation.portrait
            ? size.height * 0.05
            : size.height * 0.075,
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute<FavouritesPage>(
            builder: (context) => const FavouritesPage(),
          ),
        ),
      ),
    );
  }
}
