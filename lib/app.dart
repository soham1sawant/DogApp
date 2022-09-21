import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'core/styles/themes.dart';
import 'features/authentication/bloc/auth_bloc.dart';
import 'features/authentication/data/auth_repository.dart';
import 'features/authentication/ui/sign_in_page.dart';
import 'features/authentication/ui/sign_up_page.dart';
import 'features/dogbreeds/bloc/dogbreeds_bloc.dart';
import 'features/dogbreeds/data/dog_repository.dart';
import 'features/dogbreeds/ui/home_page.dart';
import 'features/favourites/bloc/favourites_bloc.dart';
import 'features/favourites/ui/favourites_page.dart';

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
