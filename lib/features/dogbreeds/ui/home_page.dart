import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/main_header.dart';
import '../../../core/widgets/main_list.dart';
import '../bloc/dogbreeds_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
              const MainHeader(header: "Dog App", icon: true),
              BlocBuilder<DogBreedsBloc, DogBreedsState>(
                builder: (context, state) {
                  if (state is DogBreedsLoadInProgress) {
                    return const Center(
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
                    return const Center(
                      child: Icon(Icons.error),
                    );
                  } else {
                    return const Center(
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