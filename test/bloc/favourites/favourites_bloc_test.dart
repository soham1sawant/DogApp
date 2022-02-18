import 'dart:convert';
import 'package:bloc_test/bloc_test.dart';
import 'package:dog_app/bloc/favourites/favourites_bloc.dart';
import 'package:dog_app/data/models/breeds/breeds_model.dart';
import 'package:dog_app/data/models/favourites_list.dart';
import 'package:dog_app/data/repositories/repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/hydrated_bloc.dart';

class MockDogRepository extends Mock implements Repository {}

void main() {
  group("FavouritesBloc", () {
    // loading and creating the mock favourite breeds
    const String mockString = '''
    [
    {
        "weight": {
          "imperial": "6 - 13",
          "metric": "3 - 6"
        },
        "height": {
          "imperial": "9 - 11.5",
          "metric": "23 - 29"
        },
        "id": 1,
        "name": "Affenpinscher",
        "bred_for": "Small rodent hunting, lapdog",
        "breed_group": "Toy",
        "life_span": "10 - 12 years",
        "temperament": "Stubborn, Curious, Playful, Adventurous, Active, Fun-loving",
        "origin": "Germany, France",
        "reference_image_id": "BJa4kxc4X",
        "image": {
          "id": "BJa4kxc4X",
          "width": 1600,
          "height": 1199,
          "url": "https://cdn2.thedogapi.com/images/BJa4kxc4X.jpg"
        }
      },
      {
        "weight": {
          "imperial": "50 - 60",
          "metric": "23 - 27"
        },
        "height": {
          "imperial": "25 - 27",
          "metric": "64 - 69"
        },
        "id": 2,
        "name": "Afghan Hound",
        "country_code": "AG",
        "bred_for": "Coursing and hunting",
        "breed_group": "Hound",
        "life_span": "10 - 13 years",
        "temperament": "Aloof, Clownish, Dignified, Independent, Happy",
        "origin": "Afghanistan, Iran, Pakistan",
        "reference_image_id": "hMyT4CDXR",
        "image": {
          "id": "hMyT4CDXR",
          "width": 606,
          "height": 380,
          "url": "https://cdn2.thedogapi.com/images/hMyT4CDXR.jpg"
        }
      }
    ]''';
    final mockJson = jsonDecode(mockString) as List;
    final List<BreedsModel> mockFavouriteBreeds = List.from(mockJson)
        .map<BreedsModel>((item) => BreedsModel.fromJsom(item))
        .toList();

   
    //loading and creating the breed to add
    const String mockAddString = '''
    {
    "weight": {
      "imperial": "38 - 50",
      "metric": "17 - 23"
    },
    "height": {
      "imperial": "23 - 26",
      "metric": "58 - 66"
    },
    "id": 8,
    "name": "Alaskan Husky",
    "bred_for": "Sled pulling",
    "breed_group": "Mixed",
    "life_span": "10 - 13 years",
    "temperament": "Friendly, Energetic, Loyal, Gentle, Confident",
    "reference_image_id": "-HgpNnGXl",
    "image": {
      "id": "-HgpNnGXl",
      "width": 500,
      "height": 500,
      "url": "https://cdn2.thedogapi.com/images/-HgpNnGXl.jpg"
    }
    }''';
    final mockAddJson = jsonDecode(mockAddString);
    final BreedsModel mockBreedToAdd = BreedsModel.fromJsom(mockAddJson);

    //loading and creating the breed to remove
    const String mockRemoveString = '''
    {
    "weight": {
      "imperial": "50 - 60",
      "metric": "23 - 27"
    },
    "height": {
      "imperial": "25 - 27",
      "metric": "64 - 69"
    },
    "id": 2,
    "name": "Afghan Hound",
    "country_code": "AG",
    "bred_for": "Coursing and hunting",
    "breed_group": "Hound",
    "life_span": "10 - 13 years",
    "temperament": "Aloof, Clownish, Dignified, Independent, Happy",
    "origin": "Afghanistan, Iran, Pakistan",
    "reference_image_id": "hMyT4CDXR",
    "image": {
      "id": "hMyT4CDXR",
      "width": 606,
      "height": 380,
      "url": "https://cdn2.thedogapi.com/images/hMyT4CDXR.jpg"
    }
    }''';
    final mockRemoveJson = jsonDecode(mockRemoveString);
    final BreedsModel mockBreedToRemove = BreedsModel.fromJsom(mockRemoveJson);

    late Repository dogRepository;

    setUp(() {
      dogRepository = MockDogRepository();
    });

    test("Initial state is FavouritesLoading", () {
      expect(FavouritesBloc(repository: dogRepository).state,
          FavouritesLoading());
    });

    blocTest<FavouritesBloc, FavouritesState>(
      "emits [FavouritesLoading, FavouritesLoaded]"
      "when favourites is loaded successfullly",
      setUp: () {
        when(dogRepository.loadFavourites).thenAnswer((_) async => []);
      },
      build: () => mockHydratedStorage(() => FavouritesBloc(repository: dogRepository)),
      act: (bloc) => bloc.add(FavouritesStarted()),
      expect: () => <FavouritesState>[
        FavouritesLoading(),
        FavouritesLoaded(favouritesList: const FavouritesList(favourites: []))
      ],
      verify: (_) => verify(dogRepository.loadFavourites).called(1),
    );

    blocTest<FavouritesBloc, FavouritesState>(
      "emits [FavouritesLoading, FavouritesLoadingError]"
      "when favourites is loaded successfullly",
      setUp: () {
        when(dogRepository.loadFavourites).thenThrow(Exception("Error"));
      },
      build: () => mockHydratedStorage(() => FavouritesBloc(repository: dogRepository)),
      act: (bloc) => bloc.add(FavouritesStarted()),
      expect: () =>
          <FavouritesState>[FavouritesLoading(), FavouritesLoadingError()],
      verify: (_) => verify(dogRepository.loadFavourites).called(1),
    );

    blocTest<FavouritesBloc, FavouritesState>(
      "emits [] when favourites is not loaded and breed is added",
      setUp: () {
        when(dogRepository.loadFavourites).thenAnswer((_) async {
          return <BreedsModel>[];
        });
      },
      build: () => mockHydratedStorage(() => FavouritesBloc(repository: dogRepository)),
      act: (bloc) => bloc.add(FavouritesAdded(mockBreedToAdd)),
      expect: () => <FavouritesState>[],
    );

    blocTest<FavouritesBloc, FavouritesState>(
      "emits [FavouritesLoaded] when breed is added successfully",
      setUp: () {
        when(() => dogRepository.addBreedToFavourites(mockBreedToAdd))
            .thenAnswer((_) async {});
      },
      build: () => mockHydratedStorage(() => FavouritesBloc(repository: dogRepository)),
      seed: () => FavouritesLoaded(
          favouritesList: FavouritesList(favourites: mockFavouriteBreeds)),
      act: (bloc) => bloc.add(FavouritesAdded(mockBreedToAdd)),
      expect: () => <FavouritesState>[
        FavouritesLoaded(
          favouritesList: FavouritesList(
              favourites: [...mockFavouriteBreeds, mockBreedToAdd]),
        )
      ],
      verify: (_) {
        verify(() => dogRepository.addBreedToFavourites(mockBreedToAdd))
            .called(1);
      },
    );

    blocTest<FavouritesBloc, FavouritesState>(
      "emits [FavouritesLoadingError] when breed is not added successfully",
      setUp: () {
        when(() => dogRepository.addBreedToFavourites(mockBreedToAdd))
            .thenThrow(Exception("Error"));
      },
      build: () => mockHydratedStorage(() => FavouritesBloc(repository: dogRepository)),
      seed: () => FavouritesLoaded(
          favouritesList: FavouritesList(favourites: mockFavouriteBreeds)),
      act: (bloc) => bloc.add(FavouritesAdded(mockBreedToAdd)),
      expect: () => <FavouritesState>[FavouritesLoadingError()],
      verify: (_) {
        verify(() => dogRepository.addBreedToFavourites(mockBreedToAdd))
            .called(1);
      },
    );

    blocTest<FavouritesBloc, FavouritesState>(
      "emits [FavouritesLoaded] when breed is removed successfully",
      setUp: () {
        when(() => dogRepository.removeBreedFromFavourites(mockBreedToRemove))
            .thenAnswer((_) async {});
      },
      build: () => mockHydratedStorage(() => FavouritesBloc(repository: dogRepository)),
      seed: () => FavouritesLoaded(
          favouritesList: FavouritesList(favourites: mockFavouriteBreeds)),
      act: (bloc) => bloc.add(FavouritesRemoved(mockBreedToRemove)),
      expect: () => <FavouritesState>[
        FavouritesLoaded(
          favouritesList:
              FavouritesList(favourites: [...mockFavouriteBreeds]..remove(mockBreedToRemove)),
        )
      ],
      verify: (_) {
        verify(() => dogRepository.removeBreedFromFavourites(mockBreedToRemove))
            .called(1);
      },
    );

    blocTest<FavouritesBloc, FavouritesState>(
      "emits [FavouritesLoadingError] when item is not removed successfully",
      setUp: () {
        when(() => dogRepository.removeBreedFromFavourites(mockBreedToRemove))
            .thenThrow(Exception("Error"));
      },
      build: () => mockHydratedStorage(() => FavouritesBloc(repository: dogRepository)),
      seed: () => FavouritesLoaded(
          favouritesList: FavouritesList(favourites: mockFavouriteBreeds)),
      act: (bloc) => bloc.add(FavouritesRemoved(mockBreedToRemove)),
      expect: () => <FavouritesState>[FavouritesLoadingError()],
      verify: (_) {
        verify(() => dogRepository.removeBreedFromFavourites(mockBreedToRemove))
            .called(1);
      },
    );
  });
}
