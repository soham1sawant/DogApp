import 'package:dog_app/features/dogbreeds/ui/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dog_app/features/favourites/bloc/favourites_bloc.dart';
import 'package:dog_app/features/favourites/ui/widgets/badge_icon.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({
    Key? key,
    required this.header,
    required this.favIcon,
    required this.settingsIcon,
  }) : super(key: key);

  final String header;
  final bool favIcon;
  final bool settingsIcon;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          header,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
          textScaleFactor: size.height * 0.0045,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (favIcon)
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
            if (settingsIcon)
              IconButton(
                key: const Key('to-settings-page'),
                icon: const Icon(Icons.settings),
                color: Theme.of(context).primaryColor,
                iconSize: size.height * 0.05,
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute<SettingsPage>(
                    builder: (context) => const SettingsPage(),
                  ),
                ),
              )
          ],
        ),
      ],
    );
  }
}
