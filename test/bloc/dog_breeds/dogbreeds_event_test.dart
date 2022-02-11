import 'package:dog_app/bloc/dog_breeds/dogbreeds_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("DogBreedsEvent", () {
    group("DogBreedsRequest", () {
      test('supports value comparison', () {
        expect(DogBreedsRequest(), DogBreedsRequest());
      });
    });
  });
}
