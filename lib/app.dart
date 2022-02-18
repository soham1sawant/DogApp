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
  const App({Key? key, required this.dogDataRepository}) : super(key: key);

  final Repository dogDataRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                DogBreedsBloc(dogDataRepository: dogDataRepository)
                  ..add(DogBreedsRequest())),
        BlocProvider(
            create: (context) =>
                FavouritesBloc(dogDataRepository: dogDataRepository)
                  ..add(FavouritesStarted())),
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
    );
  }
}
