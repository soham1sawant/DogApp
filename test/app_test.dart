import 'dart:convert';

import 'package:dog_app/app.dart';
import 'package:dog_app/data/models/breeds/breeds_model.dart';
import 'package:dog_app/data/repositories/repository.dart';
import 'package:dog_app/presentation/pages/favourite_page/favourites_page.dart';
import 'package:dog_app/presentation/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'helpers/hydrated_bloc.dart';

class MockDogRepository extends Mock implements Repository {}

void main() {
  group("App", () {
    late Repository dogRepository;

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
    final List<BreedsModel> mockBreeds = List.from(mockJson)
        .map<BreedsModel>((item) => BreedsModel.fromJsom(item))
        .toList();

    setUp(() {
      dogRepository = MockDogRepository();
      when(dogRepository.getDogData).thenAnswer((_) async => mockBreeds);
    });

    testWidgets("renders HomePage (initial route)", (tester) async {
      await tester.pumpWidget(App(dogDataRepository: dogRepository));
      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets(
      "can navigate back and forth"
      "between HomePage and FavouritesPage",
      (tester) async {
        await mockHydratedStorage(() async => {
              await tester.pumpWidget(
                App(dogDataRepository: dogRepository),
              ),
            });

        await tester.tap(find.byKey(const ValueKey("to-favourites-page")));
        await tester.pumpAndSettle();

        expect(find.byType(FavouritesPage), findsOneWidget);
        expect(find.byType(HomePage), findsNothing);

        final NavigatorState navigator = tester.state(find.byType(Navigator));
        navigator.pop();
        await tester.pumpAndSettle();

        expect(find.byType(HomePage), findsOneWidget);
        expect(find.byType(FavouritesPage), findsNothing);
      },
    );
  });
}
