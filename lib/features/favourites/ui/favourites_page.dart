import 'package:dog_app/core/widgets/main_header.dart';
import 'package:dog_app/core/widgets/main_list.dart';
import 'package:dog_app/features/favourites/bloc/favourites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: size.height * 0.032,
            vertical: size.width * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MainHeader(header: 'Favourites', icon: false),
              BlocBuilder<FavouritesBloc, FavouritesState>(
                builder: (context, state) {
                  if (state is FavouritesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is FavouritesLoaded) {
                    return Expanded(
                      child: MainList(
                        breeds: state.favouritesList.favourites,
                        removeButton: true,
                        isFavouritesPage: true,
                      ),
                    );
                  } else if (state is FavouritesLoadingError) {
                    return const Center(child: Icon(Icons.error_outline));
                  } else {
                    return const Center(child: Icon(Icons.error_outline));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
