import 'dart:convert';

import 'package:dog_app/features/authentication/bloc/auth_bloc.dart';
import 'package:dog_app/features/dogbreeds/bloc/dogbreeds_bloc.dart';
import 'package:dog_app/features/dogbreeds/ui/home_detail_page.dart';
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
      }''';

  final mockJson = jsonDecode(mockString);
  final mockDogBreed = BreedsModel.fromJsom(mockJson as Map<String, dynamic>);

  setUp(() {
    dogBreedsBloc = MockDogBreedsBloc();
    authBloc = MockAuthBloc();
    favouritesBloc = MockFavouritesBloc();
  });

  group('HomeDetailPage', () {
    testWidgets('renders Home Detail Page', (tester) async {
      when(() => dogBreedsBloc.state).thenReturn(DogBreedsLoadInProgress());
      when(() => authBloc.state).thenReturn(AuthenticatedState());
      when(() => favouritesBloc.state).thenReturn(FavouritesLoading());

      await tester.pumpApp(
        dogBreedsBloc: dogBreedsBloc,
        authBloc: authBloc,
        favouritesBloc: favouritesBloc,
        child: HomeDetailPage(theBreed: mockDogBreed),
      );

      expect(find.byType(HomeDetailPage), findsOneWidget);
    });
  });

  group('SnackBAr', () {
    testWidgets('shows SnackBar saying, Added to Favourites', (tester) async {
      when(() => dogBreedsBloc.state).thenReturn(DogBreedsLoadInProgress());
      when(() => authBloc.state).thenReturn(AuthenticatedState());
      when(() => favouritesBloc.state).thenReturn(
        FavouritesLoaded(
          favouritesList: const FavouritesList(),
        ),
      );

      await tester.pumpApp(
        dogBreedsBloc: dogBreedsBloc,
        authBloc: authBloc,
        favouritesBloc: favouritesBloc,
        child: HomeDetailPage(theBreed: mockDogBreed),
      );

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();
      expect(find.text('Added to Favourites'), findsOneWidget);
    });

    testWidgets('shows SnackBar saying, Removed from Favourites',
        (tester) async {
      when(() => dogBreedsBloc.state).thenReturn(DogBreedsLoadInProgress());
      when(() => authBloc.state).thenReturn(AuthenticatedState());
      when(() => favouritesBloc.state).thenReturn(
        FavouritesLoaded(
          favouritesList: FavouritesList(favourites: [mockDogBreed]),
        ),
      );

      await tester.pumpApp(
        dogBreedsBloc: dogBreedsBloc,
        authBloc: authBloc,
        favouritesBloc: favouritesBloc,
        child: HomeDetailPage(theBreed: mockDogBreed),
      );

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();
      expect(find.text('Removed from Favourites'), findsOneWidget);
    });
  });

  group('FloatingActionButton', () {
    testWidgets('FloatingActionButton heart becomes red when tapped',
        (tester) async {
      when(() => dogBreedsBloc.state).thenReturn(DogBreedsLoadInProgress());
      when(() => authBloc.state).thenReturn(AuthenticatedState());
      when(() => favouritesBloc.state).thenReturn(
        FavouritesLoaded(
          favouritesList: const FavouritesList(),
        ),
      );

      await tester.pumpApp(
        dogBreedsBloc: dogBreedsBloc,
        authBloc: authBloc,
        favouritesBloc: favouritesBloc,
        child: HomeDetailPage(theBreed: mockDogBreed),
      );
      expect(find.byKey(const Key('unliked_heart')), findsOneWidget);

      await tester.tap(find.byType(FloatingActionButton));
      verify(() => favouritesBloc.add(FavouritesAdded(mockDogBreed)));
    });

    testWidgets('FloatingActionButton heart becomes colorless when tapped',
        (tester) async {
      when(() => dogBreedsBloc.state).thenReturn(DogBreedsLoadInProgress());
      when(() => authBloc.state).thenReturn(AuthenticatedState());
      when(() => favouritesBloc.state).thenReturn(
        FavouritesLoaded(
          favouritesList: FavouritesList(favourites: [mockDogBreed]),
        ),
      );

      await tester.pumpApp(
        dogBreedsBloc: dogBreedsBloc,
        authBloc: authBloc,
        favouritesBloc: favouritesBloc,
        child: HomeDetailPage(theBreed: mockDogBreed),
      );
      expect(find.byKey(const Key('liked_heart')), findsOneWidget);

      await tester.tap(find.byType(FloatingActionButton));
      verify(() => favouritesBloc.add(FavouritesRemoved(mockDogBreed)));
    });
  });
}
