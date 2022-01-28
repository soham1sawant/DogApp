import 'dart:convert';
import 'package:dog_app/bloc/favourites/favourites_bloc.dart';
import 'package:dog_app/data/models/breeds.dart';
import 'package:dog_app/data/repositories/dog_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDogRepository extends Mock implements DogRepository {}

void main() {
  group("FavouritesBloc", () {
    // loading and creating the mock favourite breeds
    final String mockString = '''
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
        .map<BreedsModel>((item) => BreedsModel.fromMap(item))
        .toList();

    //loading and creating the breed to add
    final String mockAddString = '''
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
    final BreedsModel mockBreedToAdd = BreedsModel.fromMap(mockAddJson);

    //loading and creating the breed to remove
    final String mockRemoveString = '''
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
    final BreedsModel mockBreedToRemove = BreedsModel.fromMap(mockRemoveJson);

    DogRepository dogRepository;

    setUp(() {
      dogRepository = MockDogRepository();
    });

    test("Initial state is FavouritesLoading", () {
      expect(FavouritesBloc(dogDataRepository: dogRepository).state,
          FavouritesLoading());
    });
  });
}
