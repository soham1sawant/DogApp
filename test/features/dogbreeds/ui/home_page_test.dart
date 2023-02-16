import 'dart:convert';

import 'package:dog_app/features/favourites/ui/widgets/badge_icon.dart';
import 'package:dog_app/core/widgets/main_list.dart';
import 'package:dog_app/features/authentication/bloc/auth_bloc.dart';
import 'package:dog_app/features/dogbreeds/bloc/dogbreeds_bloc.dart';
import 'package:dog_app/features/dogbreeds/models/breeds_catalog.dart';
import 'package:dog_app/features/dogbreeds/ui/home_page.dart';
import 'package:dog_app/features/favourites/bloc/favourites_bloc.dart';
import 'package:dog_app/features/favourites/data/favourites_list.dart';
import 'package:dogbreeds_api/dogbreeds_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helper.dart';

void main() {
  late DogBreedsBloc dogBreedsBloc;
  late AuthBloc authBloc;
  late FavouritesBloc favouritesBloc;

  const mockString = '''
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
  final mockDogBreeds = mockJson
      .map<BreedsModel>(
        (item) => BreedsModel.fromJsom(item as Map<String, dynamic>),
      )
      .toList();

  setUp(() {
    dogBreedsBloc = MockDogBreedsBloc();
    authBloc = MockAuthBloc();
    favouritesBloc = MockFavouritesBloc();
  });

  group('HomePage', () {
    testWidgets('renders Home Page', (tester) async {
      when(() => dogBreedsBloc.state).thenReturn(DogBreedsLoadInProgress());
      when(() => authBloc.state).thenReturn(AuthenticatedState());
      when(() => favouritesBloc.state).thenReturn(FavouritesLoading());

      await tester.pumpApp(
        dogBreedsBloc: dogBreedsBloc,
        authBloc: authBloc,
        favouritesBloc: favouritesBloc,
        child: const HomePage(),
      );

      expect(find.byType(HomePage), findsOneWidget);
    });
  });

  group('Dogbreeds List', () {
    testWidgets('renders CircularProgressIndicator when breeds list is loading',
        (tester) async {
      when(() => dogBreedsBloc.state).thenReturn(DogBreedsLoadInProgress());
      when(() => authBloc.state).thenReturn(AuthenticatedState());
      when(() => favouritesBloc.state).thenReturn(FavouritesLoading());

      await tester.pumpApp(
        dogBreedsBloc: dogBreedsBloc,
        authBloc: authBloc,
        favouritesBloc: favouritesBloc,
        child: const HomePage(),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders MainList when dog breeds is loaded with 2 breeds',
        (tester) async {
      when(() => dogBreedsBloc.state)
          .thenReturn(DogBreedsLoadSuccess(BreedsCatalog(mockDogBreeds)));
      when(() => authBloc.state).thenReturn(AuthenticatedState());
      when(() => favouritesBloc.state).thenReturn(FavouritesLoading());

      await tester.pumpApp(
        dogBreedsBloc: dogBreedsBloc,
        authBloc: authBloc,
        favouritesBloc: favouritesBloc,
        child: const HomePage(),
      );

      expect(find.byType(MainList), findsOneWidget);
    });

    testWidgets('renders BadgeIcon when Favourites breeds is loaded',
        (tester) async {
      when(() => dogBreedsBloc.state).thenReturn(DogBreedsLoadInProgress());
      when(() => authBloc.state).thenReturn(AuthenticatedState());
      when(() => favouritesBloc.state).thenReturn(
        FavouritesLoaded(
          favouritesList: FavouritesList(favourites: mockDogBreeds),
        ),
      );

      await tester.pumpApp(
        dogBreedsBloc: dogBreedsBloc,
        authBloc: authBloc,
        favouritesBloc: favouritesBloc,
        child: const HomePage(),
      );

      expect(find.byType(BadgeIcon), findsOneWidget);
    });

    testWidgets('renders Error Icon when dog breeds fail to load',
        (tester) async {
      when(() => dogBreedsBloc.state).thenReturn(DogBreedsLoadFailure());
      when(() => authBloc.state).thenReturn(AuthenticatedState());
      when(() => favouritesBloc.state).thenReturn(FavouritesLoading());

      await tester.pumpApp(
        dogBreedsBloc: dogBreedsBloc,
        authBloc: authBloc,
        favouritesBloc: favouritesBloc,
        child: const HomePage(),
      );

      expect(find.byIcon(Icons.error), findsOneWidget);
    });
  });

  group('Sign Out', () {
    testWidgets('renders Login Page when FloatingActionButton is pressed',
        (tester) async {
      when(() => dogBreedsBloc.state)
          .thenReturn(DogBreedsLoadSuccess(BreedsCatalog(mockDogBreeds)));
      when(() => authBloc.state).thenReturn(AuthenticatedState());
      when(() => favouritesBloc.state).thenReturn(FavouritesLoading());
      //when(() => authRepository.signOut).thenReturn(() async {});

      await tester.pumpApp(
        dogBreedsBloc: dogBreedsBloc,
        authBloc: authBloc,
        favouritesBloc: favouritesBloc,
        child: const HomePage(),
      );
      expect(find.byType(HomePage), findsOneWidget);

      await tester.tap(find.byType(FloatingActionButton));

      verify(() => authBloc.add(const SignOutRequested()));
    });
  });
}
