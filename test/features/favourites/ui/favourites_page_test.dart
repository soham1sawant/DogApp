import 'dart:convert';

import 'package:dog_app/features/dogbreeds/models/breeds/breeds_model.dart';
import 'package:dog_app/features/favourites/bloc/favourites_bloc.dart';
import 'package:dog_app/features/favourites/models/favourites_list.dart';
import 'package:dog_app/features/favourites/ui/favourites_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helper.dart';

void main() {
  late FavouritesBloc favouritesBloc;

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

  setUp(() {
    favouritesBloc = MockFavouritesBloc();
  });

  group("FavouritesPage", () {
    testWidgets("renders FavouritesPage", (tester) async {
      when(() => favouritesBloc.state).thenReturn(FavouritesLoading());
      await tester.pumpApp(
        favouritesBloc: favouritesBloc,
        child: const FavouritesPage(),
      );

      expect(find.byType(FavouritesPage), findsOneWidget);
    });
  });

  group("FavouritesList", () {
    testWidgets(
      "renders CircularProgressIndicator when favourites is loading",
      (tester) async {
        when(() => favouritesBloc.state).thenReturn(FavouritesLoading());
        await tester.pumpApp(
          favouritesBloc: favouritesBloc,
          child: const FavouritesPage(),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      "renders 2 InkWell when favourites is loaded with 2 breeds",
      (tester) async {
        when(() => favouritesBloc.state).thenReturn(FavouritesLoaded(
            favouritesList: FavouritesList(favourites: mockFavouriteBreeds)));
        await tester.pumpApp(
          favouritesBloc: favouritesBloc,
          child: const FavouritesPage(),
        );

        expect(find.byType(InkWell), findsNWidgets(2));
      },
    );

    testWidgets(
      "renders error_outline icon when favourites is loading throws an error",
      (tester) async {
        when(() => favouritesBloc.state).thenReturn(FavouritesLoadingError());
        await tester.pumpApp(
          favouritesBloc: favouritesBloc,
          child: const FavouritesPage(),
        );

        expect(find.byIcon(Icons.error_outline), findsOneWidget);
      },
    );

    testWidgets(
      "renders SnackBar when favourites is removed using removebutton",
      (tester) async {
        when(() => favouritesBloc.state).thenReturn(FavouritesLoaded(
            favouritesList: FavouritesList(favourites: mockFavouriteBreeds)));
        await tester.pumpApp(
          favouritesBloc: favouritesBloc,
          child: const FavouritesPage(),
        );

        expect(find.byKey(const Key("remove-Affenpinscher")), findsOneWidget);
        await tester.tap(find.byKey(const Key("remove-Affenpinscher")));
        await tester.pumpAndSettle();
        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text("Removed from Favourites"), findsOneWidget);

        expect(find.byKey(const Key("remove-Afghan Hound")), findsOneWidget);
        await tester.tap(find.byKey(const Key("remove-Afghan Hound")));
        await tester.pumpAndSettle();
        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text("Removed from Favourites"), findsOneWidget);
      },
    );
  });
}
