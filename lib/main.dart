import 'package:dog_app/bloc/dog_breeds/dogbreeds_bloc.dart';
import 'package:dog_app/bloc/favourites/favourites_bloc.dart';
import 'package:dog_app/data/repositories/dog_data_repository.dart';
import 'package:dog_app/presentation/pages/favourite_page/favourites_page.dart';
import 'package:dog_app/presentation/pages/home_page/home_page.dart';
import 'package:dog_app/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/themes.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(App()),
    blocObserver: SimpleBlocObserver(),
  );
}

class App extends StatelessWidget {
  App({Key key}) : super(key: key);

  final DogDataRepository dogDataRepository = DogDataRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => DogBreedsBloc()..add(DogBreedsRequest())),
        BlocProvider(
            create: (context) => FavouritesBloc(dogDataRepository)..add(FavouritesStarted())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: MyTheme.lightTheme(context),
        darkTheme: MyTheme.darkTheme(context),
        initialRoute: '/',
        routes: {
          '/': (_) => HomePage(),
          '/favourites': (_) => FavouritesPage(),
        },
      ),
    );
  }
}