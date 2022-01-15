import 'features/dog_data/viewmodel/dog_data_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'features/favourite_breeds/viewmodel/favourite_breeds_viewmodel.dart';
import 'view/pages/home page/home_page.dart';
import 'view/themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavouriteBreeds()),
        ChangeNotifierProvider(create: (context) => DogData()),
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
