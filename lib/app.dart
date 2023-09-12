import 'package:authentication_repo/authentication_repo.dart';
import 'package:dog_app/core/styles/themes.dart';
import 'package:dog_app/features/authentication/bloc/auth_bloc.dart';
import 'package:dog_app/features/authentication/ui/sign_in_page.dart';
import 'package:dog_app/features/dogbreeds/bloc/dogbreeds_bloc.dart';
import 'package:dog_app/features/dogbreeds/ui/home_page.dart';
import 'package:dog_app/features/favourites/bloc/favourites_bloc.dart';
import 'package:dogbreeds_api/dogbreeds_api.dart';
import 'package:favourites_api/favourites_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.light;

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<DogbreedsApiClient>(
          create: (context) => DogbreedsApiClient(),
        ),
        RepositoryProvider<FavouritesApi>(
          create: (context) => FavouritesApi(),
        ),
        RepositoryProvider<AuthenticationRepo>(
          create: (context) => AuthenticationRepo(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DogBreedsBloc(
              RepositoryProvider.of<DogbreedsApiClient>(context),
            )..add(DogBreedsRequest()),
          ),
          BlocProvider(
            create: (context) => FavouritesBloc(
              favouritesRepository:
                  RepositoryProvider.of<FavouritesApi>(context),
            )..add(FavouritesStarted()),
          ),
          BlocProvider(
            create: (context) => AuthBloc(
              authRepo: RepositoryProvider.of<AuthenticationRepo>(context),
            )..add(const CheckAuthEvent()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: MyTheme.lightTheme(context),
          darkTheme: MyTheme.darkTheme(context),
          home: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AuthenticatedState) {
                return const HomePage();
              } else if (state is UnAuthenticatedState) {
                return SignInPage();
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
