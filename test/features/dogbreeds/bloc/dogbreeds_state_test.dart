import 'package:dog_app/features/dogbreeds/bloc/dogbreeds_bloc.dart';
import 'package:dog_app/features/dogbreeds/models/breeds_catalog.dart';
import 'package:dogbreeds_api/dogbreeds_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DogBreedsState', () {

    // group('DogBreedsState', () {
    //   test('supports value comparison', () {
    //     expect(DogBreedsState(), DogBreedsState());
    //   });
    // });
    group('DogBreedsLoadInProgress', () {
      test('supports value comparison', () {
        expect(DogBreedsLoadInProgress(), DogBreedsLoadInProgress());
      });
    });
  });

  group('DogBreedsLoadSuccess', () {
    test('supports value comparison', () {
      const breedsCatalog = BreedsCatalog(<BreedsModel>[]);
      expect(DogBreedsLoadSuccess(breedsCatalog),
          DogBreedsLoadSuccess(breedsCatalog),);
    });
  });

  group('DogBreedsLoadFailure', () {
    test('supports value comparison', () {
      expect(DogBreedsLoadFailure(), DogBreedsLoadFailure());
    });
  });
}
