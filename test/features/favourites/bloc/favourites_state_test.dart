import 'package:dog_app/features/favourites/bloc/favourites_bloc.dart';
import 'package:dog_app/features/favourites/data/favourites_list.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FavouritesState', () {
    group('FavouritesLoading', () {
      test('supports value comparison', () {
        expect(FavouritesLoading(), FavouritesLoading());
      });
    });

    group('FavouritesLoaded', () {
      test('supports value comparison', () {
        expect(FavouritesLoaded(favouritesList: const FavouritesList()),
            FavouritesLoaded(favouritesList: const FavouritesList()),);
      });
    });

    group('FavouritesLoadingError', () {
      test('supports value comparison', () {
        expect(FavouritesLoadingError(), FavouritesLoadingError());
      });
    });
  });
}
