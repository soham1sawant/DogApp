import 'logic/bloc/favourite_button/favourite_cubit.dart';
import 'data/repository/data_repository.dart';
import 'logic/simple_bloc_observer.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'logic/bloc/data/data_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(storageDirectory: await getApplicationDocumentsDirectory());

  final DataRepository dataRepository = DataRepository();
  runApp(MyApp(dataRepository: dataRepository));
}

class MyApp extends StatelessWidget {
  final DataRepository dataRepository;

  const MyApp({Key key, this.dataRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DataBloc>(
          create: (context) => DataBloc(dataRepository)..add(DataRequested()),
        ),
        BlocProvider<FavouriteCubit>(
          create: (context) => FavouriteCubit(),
        ),
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
