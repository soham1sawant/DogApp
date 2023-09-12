import 'package:dog_app/features/dogbreeds/bloc/dogbreeds_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DogBreedsEvent', () {
    group('DogBreedsRequest', () {
      test('supports value comparison', () {
        expect(DogBreedsRequest(), DogBreedsRequest());
      });
    });

    group('DogBreedImageUrlRequest', () {
      test('supports value comparison', () {
        expect(DogBreedImageUrlRequest(imageId: ''),
            DogBreedImageUrlRequest(imageId: ''));
      });
    });
  });
}
