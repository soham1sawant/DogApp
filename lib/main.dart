import 'data/repository/data_repository.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/themes.dart';
import 'package:flutter/material.dart';

void main() {

  final DataRepository dataRepository = DataRepository();
  runApp(MyApp(dataRepository: dataRepository));
}

class MyApp extends StatelessWidget {
  final DataRepository dataRepository;

  const MyApp({Key key, this.dataRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      routes: {
        '/': (context) => HomePage(),
      },
    );
  }
}
