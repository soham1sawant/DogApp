import 'package:dog_app/bloc/favourite_breeds/favouritebreeds_bloc.dart';
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
              BlocBuilder<FavouriteBreedsBloc, FavouriteBreedsState>(
                builder: (context, state) {
                  if (state is FavouriteBreedsLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is FavouriteBreedsLoadSuccess) {
                    return Expanded(
                        child: MainList(
                      breeds: state.favouriteBreeds,
                      removeButton: true,
                    ));
                  } else if (state is FavouriteBreedsEmpty) {
                    return Center(
                      child: Text("No Favorites"),
                    );
                  } else if (state is FavouriteBreedsLoadFailure) {
                    return Center(
                      child: Icon(Icons.error),
                    );
                  } else {
                    return Center(
                      child: Icon(Icons.error),
                    );
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
