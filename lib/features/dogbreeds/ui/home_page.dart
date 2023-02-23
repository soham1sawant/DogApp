import 'package:dog_app/core/widgets/main_header.dart';
import 'package:dog_app/core/widgets/main_list.dart';
import 'package:dog_app/features/authentication/bloc/auth_bloc.dart';
import 'package:dog_app/features/authentication/ui/sign_in_page.dart';
import 'package:dog_app/features/dogbreeds/bloc/dogbreeds_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnAuthenticatedState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute<SignInPage>(
              builder: (context) => SignInPage(),
            ),
          );
        }
      },
      child: Scaffold(
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
                const MainHeader(
                  header: 'Dog App',
                  favIcon: true,
                  settingsIcon: true,
                ),
                BlocBuilder<DogBreedsBloc, DogBreedsState>(
                  builder: (context, state) {
                    if (state is DogBreedsLoadInProgress) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is DogBreedsLoadSuccess) {
                      return Expanded(
                        child: MainList(
                          key: const Key('main_list'),
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
        floatingActionButton: FloatingActionButton(
          key: const Key('signout_FAB'),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            BlocProvider.of<AuthBloc>(context).add(const SignOutRequested());
          },
          child: const Icon(Icons.logout),
        ),
      ),
    );
  }
}
