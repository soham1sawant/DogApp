import 'package:bloc_test/bloc_test.dart';
import 'package:dog_app/features/dogbreeds/bloc/dogbreeds_bloc.dart';
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
        when(() => dogbreedsApiClient.dogData())
            .thenAnswer((_) async => mockDogsList);
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

    blocTest<DogBreedsBloc, DogBreedsState>(
      'emites [DogBreedImageUrlLoadInProgress, DogBreedImageUrlLoadSuccess'
      'when loading dog breed url is loaded',
      setUp: () {
        when(() => dogbreedsApiClient.getImageUrl(''))
            .thenAnswer((_) async => mockImageUrl);
      },
      build: () => DogBreedsBloc(dogbreedsApiClient),
      act: (bloc) => bloc.add(DogBreedImageUrlRequest(imageId: '')),
      expect: () => <DogBreedsState>[
        DogBreedImageUrlLoadInProgress(),
        DogBreedImageUrlLoadSuccess(mockImageUrl),
      ],
    );

    blocTest<DogBreedsBloc, DogBreedsState>(
      'emites [DogBreedImageUrlLoadInProgress, DogBreedImageUrlFailure'
      'when loading dog breed url is not loaded',
      setUp: () {
        when(() => dogbreedsApiClient.getImageUrl(''))
            .thenThrow(Exception('Error'));
      },
      build: () => DogBreedsBloc(dogbreedsApiClient),
      act: (bloc) => bloc.add(DogBreedImageUrlRequest(imageId: '')),
      expect: () => <DogBreedsState>[
        DogBreedImageUrlLoadInProgress(),
        DogBreedImageUrlFailure(),
      ],
    );
  });
}
