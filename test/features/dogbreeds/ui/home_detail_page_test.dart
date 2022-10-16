import 'package:dog_app/features/dogbreeds/bloc/dogbreeds_bloc.dart';
import 'package:dog_app/features/dogbreeds/models/breeds_catalog.dart';
import 'package:dog_app/features/dogbreeds/ui/home_detail_page.dart';
import 'package:dog_app/features/favourites/bloc/favourites_bloc.dart';
import 'package:dog_app/features/favourites/models/favourites_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/dogbreeds_data.dart';
import '../../../helpers/helper.dart';

void main() {
  late FavouritesBloc favouritesBloc;
  late DogBreedsBloc dogBreedsBloc;

  setUp(() {
    favouritesBloc = MockFavouritesBloc();
    dogBreedsBloc = MockDogBreedsBloc();
  });
  group('Home Page Widget Tests', () {
    testWidgets('Tests if Home Detail Page loads', (tester) async {
      when(() => dogBreedsBloc.state)
          .thenReturn(DogBreedsLoadSuccess(BreedsCatalog(breeds)));
      when(() => favouritesBloc.state).thenReturn(FavouritesLoading());

      await tester.pumpApp(
        dogBreedsBloc: dogBreedsBloc,
        favouritesBloc: favouritesBloc,
        child: HomeDetailPage(theBreed: breeds[0]),
      );

      expect(find.text('Affenpinscher'), findsOneWidget);
      expect(find.text('Germany, France'), findsOneWidget);
      expect(find.text('Small rodent hunting, lapdog'), findsOneWidget);
      expect(find.text('3 - 6 kg'), findsOneWidget);
      expect(find.text('23 - 29 inches'), findsOneWidget);
    });

    testWidgets('Tests when breeds is added to favourites', (tester) async {
      when(() => dogBreedsBloc.state)
          .thenReturn(DogBreedsLoadSuccess(BreedsCatalog(breeds)));
      // ignore: prefer_const_constructors
      when(() => favouritesBloc.state).thenReturn(FavouritesLoaded(favouritesList: FavouritesList(favourites: [])));

      await tester.pumpApp(
        dogBreedsBloc: dogBreedsBloc,
        favouritesBloc: favouritesBloc,
        child: HomeDetailPage(theBreed: breeds[0]),
      );

      expect(find.byIcon(Icons.favorite_border_outlined), findsOneWidget);
      await tester.tap(find.byIcon(Icons.favorite_border_outlined));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('Added to Favourites'), findsOneWidget);

    });

    testWidgets('Tests when breed is removed from favourites', (tester) async {
       when(() => dogBreedsBloc.state)
          .thenReturn(DogBreedsLoadSuccess(BreedsCatalog(breeds)));
      when(() => favouritesBloc.state).thenReturn(FavouritesLoaded(favouritesList: FavouritesList(favourites: [breeds[0]])));

      await tester.pumpApp(
        dogBreedsBloc: dogBreedsBloc,
        favouritesBloc: favouritesBloc,
        child: HomeDetailPage(theBreed: breeds[0]),
      );

      expect(find.byIcon(Icons.favorite), findsOneWidget);
      await tester.tap(find.byIcon(Icons.favorite));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('Removed from Favourites'), findsOneWidget);
    });
  });
}
