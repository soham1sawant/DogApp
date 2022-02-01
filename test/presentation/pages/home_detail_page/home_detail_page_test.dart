import 'dart:convert';

import 'package:dog_app/app.dart';
import 'package:dog_app/data/models/breeds.dart';
import 'package:dog_app/data/repositories/dog_repository.dart';
import 'package:dog_app/presentation/pages/home_detail_page/home_detail_page.dart';
import 'package:dog_app/presentation/pages/home_page/home_page.dart';
import 'package:dog_app/presentation/widgets/main_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDogRepository extends Mock implements DogRepository {}

void main() {
  DogRepository dogRepository;

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
  final List<BreedsModel> mockBreeds = List.from(mockJson)
      .map<BreedsModel>((item) => BreedsModel.fromMap(item))
      .toList();
  final mockHomeDetailBreed = mockBreeds[0];

  group("HomeDetailPage", () {
    testWidgets("renders HomePage", (tester) async {
      await tester.pumpWidget(App(dogDataRepository: dogRepository));
      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets("renders HomeDetailPage", (tester) async {
      await tester.pumpWidget(App(dogDataRepository: dogRepository));
      await tester.pumpAndSettle();

      await tester.tap(find.text("Affenpinscher"));
      await tester.pumpAndSettle();

    });
  });
}
