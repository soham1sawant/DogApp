import 'package:dog_app/bloc/authentication/auth_bloc.dart';
import 'package:dog_app/data/repositories/auth_repository.dart';
import 'package:dog_app/presentation/pages/sign_up_page/sign_up_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/dog_breeds/dogbreeds_bloc.dart';
import 'bloc/favourites/favourites_bloc.dart';
import 'data/repositories/dog_repository.dart';
import 'presentation/pages/favourite_page/favourites_page.dart';
import 'presentation/pages/home_page/home_page.dart';
import 'presentation/pages/sign_in_page/sign_in_page.dart';
import 'presentation/themes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<DogRepository>(create: (context) => DogRepository()),
        RepositoryProvider<AuthRepository>(
            create: (context) => AuthRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DogBreedsBloc(
                repository: RepositoryProvider.of<DogRepository>(context))
              ..add(DogBreedsRequest()),
          ),
          BlocProvider(
            create: (context) => FavouritesBloc(
                repository: RepositoryProvider.of<DogRepository>(context))
              ..add(FavouritesStarted()),
          ),
          BlocProvider(
              create: (context) => AuthBloc(
                  authRepository:
                      RepositoryProvider.of<AuthRepository>(context))),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: MyTheme.lightTheme(context),
          darkTheme: MyTheme.darkTheme(context),
          routes: {
            '/signin': (context) => SignInPage(),
            '/signup': (context) => SignUpPage(),
            '/home': (context) => const HomePage(),
            '/favourites': (context) => const FavouritesPage(),
          },
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const HomePage();
              } else {
                return SignInPage();
              }
            },
          ),
        ),
      ),
    );
  }
}
