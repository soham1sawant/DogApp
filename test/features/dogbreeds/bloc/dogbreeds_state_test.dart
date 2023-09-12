import 'package:dog_app/features/dogbreeds/bloc/dogbreeds_bloc.dart';
import 'package:dogbreeds_api/dogbreeds_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DogBreedsState', () {
    group('DogBreedsLoadInProgress', () {
      test('supports value comparison', () {
        expect(DogBreedsLoadInProgress(), DogBreedsLoadInProgress());
      });
    });

    group('DogBreedsLoadSuccess', () {
      test('supports value comparison', () {
        const breedsCatalog = BreedsCatalog(<BreedsModel>[]);
        expect(
          DogBreedsLoadSuccess(breedsCatalog),
          DogBreedsLoadSuccess(breedsCatalog),
        );
      });
    });

    group('DogBreedsLoadFailure', () {
      test('supports value comparison', () {
        expect(DogBreedsLoadFailure(), DogBreedsLoadFailure());
      });
    });

    group('DogBreedImageUrlLoadInProgress', () {
      test('supports value comparison', () {
        expect(
            DogBreedImageUrlLoadInProgress(), DogBreedImageUrlLoadInProgress());
      });
    });

    group('DogBreedImageUrlLoadSuccess', () {
      test('supports value comparison', () {
        final imagePath = ImagePath('');

        expect(
          DogBreedImageUrlLoadSuccess(imagePath),
          DogBreedImageUrlLoadSuccess(imagePath),
        );
      });
    });

    group('DogBreedImageUrlFailure', () {
      test('supports value comparison', () {
        expect(DogBreedImageUrlFailure(), DogBreedImageUrlFailure());
      });
    });
  });
}
