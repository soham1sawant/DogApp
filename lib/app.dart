import 'package:dog_app/presentation/pages/login_page/login_page.dart';
import 'package:dog_app/presentation/pages/sign_up_page/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/dog_breeds/dogbreeds_bloc.dart';
import 'bloc/favourites/favourites_bloc.dart';
import 'data/repositories/repository.dart';
import 'presentation/pages/favourite_page/favourites_page.dart';
import 'presentation/pages/home_page/home_page.dart';
import 'presentation/themes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => Repository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DogBreedsBloc(
                repository: RepositoryProvider.of<Repository>(context))
              ..add(DogBreedsRequest()),
          ),
          BlocProvider(
            create: (context) => FavouritesBloc(
                repository: RepositoryProvider.of<Repository>(context))
              ..add(FavouritesStarted()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: MyTheme.lightTheme(context),
          darkTheme: MyTheme.darkTheme(context),
          initialRoute: '/',
          routes: {
            '/': (context) => LoginPage(),
            '/signup': (context) => SignUpPage(),
            '/home': (context) => const HomePage(),
            '/favourites': (context) => const FavouritesPage(),
          },
        ),
      ),
    );
  }
}
