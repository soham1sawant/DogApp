import 'package:dog_app/bloc/dog_breeds/dogbreeds_bloc.dart';
import 'package:dog_app/bloc/favourite_breeds/favouritebreeds_bloc.dart';
import 'package:dog_app/presentation/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DogBreedsBloc()..add(DogBreedsRequest())),
        BlocProvider(create: (context) => FavouriteBreedsBloc()..add(FavouriteBreedsEventRequest())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: MyTheme.lightTheme(context),
        darkTheme: MyTheme.darkTheme(context),
        routes: {
          '/': (context) => HomePage(),
        },
      ),
    );
  }
}
