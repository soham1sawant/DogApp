import 'package:bloc_test/bloc_test.dart';
import 'package:dog_app/bloc/dog_breeds/dogbreeds_bloc.dart';
import 'package:dog_app/data/models/breeds.dart';
import 'package:dog_app/data/models/breeds_catalog.dart';
import 'package:dog_app/data/repositories/dog_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDogRepository extends Mock implements DogRepository {}

void main() {
  group("DogBreedsBloc", () {
    List<BreedsModel> mockDogsList = [];
    late DogRepository dogRepository;

    setUp(() async {
      dogRepository = MockDogRepository();
    });

    test("Initial state is loading", () {
      expect(DogBreedsBloc(dogDataRepository: dogRepository).state,
          DogBreedsLoadInProgress());
    });

    blocTest<DogBreedsBloc, DogBreedsState>(
      "emits [DogBreedsLoadInProgress, DogBreedsLoadedSuccess]"
      "when dog breeds is loaded successfully",
      setUp: () {
        when(dogRepository.getDogData).thenAnswer((_) async => mockDogsList);
      },
      build: () => DogBreedsBloc(dogDataRepository: dogRepository),
      act: (bloc) => bloc.add(DogBreedsRequest()),
      expect: () => <DogBreedsState>[
        DogBreedsLoadInProgress(),
        DogBreedsLoadSuccess(BreedsCatalog(mockDogsList))
      ],
      verify: (_) => verify(dogRepository.getDogData).called(1),
    );

    blocTest<DogBreedsBloc, DogBreedsState>(
      "emites [DogBreedsLoadInProgress, DogBreedsLoadFailure"
      "when loading dog breeds throws an error",
      setUp: () {
        when(dogRepository.getDogData).thenThrow(Exception("Error"));
      },
      build: () => DogBreedsBloc(dogDataRepository: dogRepository),
      act: (bloc) => bloc.add(DogBreedsRequest()),
      expect: () => <DogBreedsState>[
        DogBreedsLoadInProgress(),
        DogBreedsLoadFailure(),
      ],
      verify: (_) => verify(dogRepository.getDogData).called(1),
    );
  });
}
