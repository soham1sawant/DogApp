import 'package:dog_app/bloc/dog_breeds/dogbreeds_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/main_header.dart';
import '../../widgets/main_list.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: orientation == Orientation.portrait
                ? size.height * 0.032
                : size.height * 0.05,
            vertical: orientation == Orientation.portrait
                ? size.width * 0.03
                : size.width * 0.015,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainHeader(header: "Dog App", icon: true),
              BlocBuilder<DogBreedsBloc, DogBreedsState>(
                builder: (context, state) {
                  if (state is DogBreedsLoadInProgress) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is DogBreedsLoadSuccess) {
                    return Expanded(
                      child: MainList(
                        key: const Key("main_list"),
                        breeds: state.breedsCatalog.loadedBreeds,
                        removeButton: false,
                        isFavouritesPage: false,
                      ),
                    );
                  } else if (state is DogBreedsLoadFailure) {
                    return Center(
                      child: const Icon(Icons.error),
                    );
                  } else {
                    return Center(
                      child: const Icon(Icons.error),
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
