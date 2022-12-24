import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/styles/themes.dart';
import 'features/dogbreeds/bloc/dogbreeds_bloc.dart';
import 'features/dogbreeds/data/dog_repository.dart';
import 'features/dogbreeds/ui/home_page.dart';
import 'features/favourites/bloc/favourites_bloc.dart';
import 'features/favourites/ui/favourites_page.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final brightness = SchedulerBinding.instance.window.platformBrightness;

  @override
  Widget build(BuildContext context) {
  bool isDarkMode = brightness == Brightness.dark;

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
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: MyTheme.lightTheme(context),
          darkTheme: MyTheme.darkTheme(context),
          routes: {
            '/home': (context) => const HomePage(),
            '/favourites': (context) => const FavouritesPage(),
          },
          home: const HomePage(),
        ),
      ),
    );
  }
}
