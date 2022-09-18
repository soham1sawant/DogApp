import 'package:dog_app/features/favourites/bloc/favourites_bloc.dart';
import 'package:dog_app/features/favourites/models/favourites_list.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeFavouritesList extends Fake implements FavouritesList {}

void main() {
  group("FavouritesState", () {
    group("FavouritesLoading", () {
      test("supports value comparison", () {
        expect(FavouritesLoading(), FavouritesLoading());
      });
    });

    group("FavouritesLoaded", () {
      final favouritesList = FakeFavouritesList();
      test("supports value comparison", () {
        expect(FavouritesLoaded(favouritesList: favouritesList), FavouritesLoaded(favouritesList: favouritesList));
      });
    });
  });

  group("FavouritesLoadingError", () {
      test("supports value comparison", () {
        expect(FavouritesLoadingError(), FavouritesLoadingError());
      });
    });
}
