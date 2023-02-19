import 'package:bloc_test/bloc_test.dart';
import 'package:dog_app/features/authentication/bloc/auth_bloc.dart';
import 'package:dog_app/features/dogbreeds/bloc/dogbreeds_bloc.dart';
import 'package:dog_app/features/favourites/bloc/favourites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';


class MockDogBreedsBloc extends MockBloc<DogBreedsEvent, DogBreedsState>
    implements DogBreedsBloc {}

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

class MockFavouritesBloc extends MockBloc<FavouritesEvent, FavouritesState>
    implements FavouritesBloc {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp({
    DogBreedsBloc? dogBreedsBloc,
    AuthBloc? authBloc,
    FavouritesBloc? favouritesBloc,
    required Widget child,
  }) {
    return pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            if (dogBreedsBloc != null)
              BlocProvider.value(value: dogBreedsBloc)
            else
              BlocProvider(create: (_) => MockDogBreedsBloc()),
            if (authBloc != null)
              BlocProvider.value(value: authBloc)
            else
              BlocProvider(create: (_) => MockAuthBloc()),
            if (favouritesBloc != null)
              BlocProvider.value(value: favouritesBloc)
            else
              BlocProvider(create: (_) => MockFavouritesBloc()),
          ],
          child: child,
        ),
      ),
    );
  }
}
