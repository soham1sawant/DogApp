import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/styles/themes.dart';
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
          
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: MyTheme.lightTheme(context),
          darkTheme: MyTheme.darkTheme(context),
          routes: {
            '/home': (context) => const HomePage(),
            '/favourites': (context) => const FavouritesPage(),
          },
          home: HomePage(),
        ),
      ),
    );
  }
}
