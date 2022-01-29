import 'package:dog_app/bloc/favourites/favourites_bloc.dart';
import 'package:dog_app/data/models/breeds.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeBreedsModel extends Fake implements BreedsModel {}

void main() {
  group("FavouritesEvent", () {
    group("FavouritesStarted", () {
      test("supports value comparison", () {
        expect(FavouritesStarted(), FavouritesStarted());
      });
    });

    group("FavouritesAdded", () {
      final breed = FakeBreedsModel();
      test("supports value comparison", () {
        expect(FavouritesAdded(breed), FavouritesAdded(breed));
      });
    });

    group("FavouritesRemoved", () {
      final breed = FakeBreedsModel();
      test("supports value comparison", () {
        expect(FavouritesRemoved(breed), FavouritesRemoved(breed));
      });
    });
  });
}
