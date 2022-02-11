import 'package:bloc_test/bloc_test.dart';
import 'package:dog_app/bloc/dog_breeds/dogbreeds_bloc.dart';
import 'package:dog_app/bloc/favourites/favourites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class MockDogBreedsBloc extends MockBloc<DogBreedsEvent, DogBreedsState>
    implements DogBreedsBloc {}

class MockFavouritesBloc extends MockBloc<FavouritesEvent, FavouritesState>
    implements FavouritesBloc {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp({
    DogBreedsBloc dogBreedsBloc,
    FavouritesBloc favouritesBloc,
    @required Widget child,
  }) {
    return pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            dogBreedsBloc != null
                ? BlocProvider.value(value: dogBreedsBloc)
                : BlocProvider(create: (_) => MockDogBreedsBloc()),
            favouritesBloc != null
                ? BlocProvider.value(value: favouritesBloc)
                : BlocProvider(create: (_) => MockFavouritesBloc()),
          ],
          child: child,
        ),
      ),
    );
  }
}
