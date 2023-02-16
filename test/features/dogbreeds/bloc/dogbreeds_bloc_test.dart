import 'package:bloc_test/bloc_test.dart';
import 'package:dog_app/features/dogbreeds/bloc/dogbreeds_bloc.dart';
import 'package:dog_app/features/dogbreeds/models/breeds_catalog.dart';
import 'package:dogbreeds_api/dogbreeds_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/mock_lists.dart';

class MockDogbreedsApiClient extends Mock implements DogbreedsApiClient {}

void main() {
  group('DogBreedsBloc', () {
    final mockDogsList = mockFavouriteBreeds;
    late DogbreedsApiClient dogbreedsApiClient;

    setUp(() async {
      dogbreedsApiClient = MockDogbreedsApiClient();
    });

    test('Initial state is loading', () {
      expect(
        DogBreedsBloc(dogbreedsApiClient).state,
        DogBreedsLoadInProgress(),
      );
    });

    blocTest<DogBreedsBloc, DogBreedsState>(
      'emits [DogBreedsLoadInProgress, DogBreedsLoadedSuccess] '
      'when dog breeds is loaded successfully',
      setUp: () {
        when(() => dogbreedsApiClient.dogData()).thenAnswer((_) async =>  mockDogsList);
      },
      build: () => DogBreedsBloc(dogbreedsApiClient),
      act: (bloc) => bloc.add(DogBreedsRequest()),
      expect: () => <DogBreedsState>[
        DogBreedsLoadInProgress(),
        DogBreedsLoadSuccess(BreedsCatalog(mockDogsList))
      ],
    );

    blocTest<DogBreedsBloc, DogBreedsState>(
      'emites [DogBreedsLoadInProgress, DogBreedsLoadFailure '
      'when loading dog breeds throws an error',
      setUp: () {
        when(() => dogbreedsApiClient.dogData()).thenThrow(Exception('Error'));
      },
      build: () => DogBreedsBloc(dogbreedsApiClient),
      act: (bloc) => bloc.add(DogBreedsRequest()),
      expect: () => <DogBreedsState>[
        DogBreedsLoadInProgress(),
        DogBreedsLoadFailure(),
      ],
    );
  });
}
