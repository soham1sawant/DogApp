import 'package:dog_app/bloc/favourites/favourites_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/main_header.dart';
import '../../widgets/main_list.dart';
import 'package:flutter/material.dart';

class FavouritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainHeader(header: "Favourites", icon: false),
              BlocBuilder<FavouritesCubit, FavouritesState>(
                builder: (context, state) {
                  if (state is FavouritesAdded) {
                    return Expanded(
                        child: MainList(
                      breeds: state.favouriteBreeds,
                      removeButton: true,
                    ));
                  }
                  else if (state is FavouritesRemoved) {
                    return Expanded(
                        child: MainList(
                      breeds: state.favouriteBreeds,
                      removeButton: true,
                    ));
                  }
                  else if (state is FavouritesInitial) {
                    return Expanded(
                        child: MainList(
                      breeds: state.favouriteBreeds,
                      removeButton: true,
                    ));
                  }
                  else {
                    return Expanded(
                        child: MainList(
                      breeds: state.favouriteBreeds,
                      removeButton: true,
                    ));
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
