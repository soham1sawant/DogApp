import 'package:dog_app/bloc/dog_breeds/dogbreeds_bloc.dart';
import 'package:dog_app/data/models/breeds.dart';
import 'package:dog_app/data/models/breeds_catalog.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("DogBreedsState", () {
    group("DogBreedsLoadInProgress", () {
      test("supports value comparison", () {
        expect(DogBreedsLoadInProgress(), DogBreedsLoadInProgress());
      });
    });
  });

  group("DogBreedsLoadSuccess", () {
    test("supports value comparison", () {
      const breedsCatalog = BreedsCatalog(<BreedsModel>[]);
      expect(DogBreedsLoadSuccess(breedsCatalog),
          DogBreedsLoadSuccess(breedsCatalog));
    });
  });

  group("DogBreedsLoadFailure", () {
    test("supports value comparison", () {
      expect(DogBreedsLoadFailure(), DogBreedsLoadFailure());
    });
  });
}
