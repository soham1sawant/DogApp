import 'package:dog_app/features/dogbreeds/bloc/dogbreeds_bloc.dart';
import 'package:dog_app/features/dogbreeds/models/breeds_catalog.dart';
import 'package:dog_app/features/dogbreeds/ui/home_page.dart';
import 'package:dog_app/features/favourites/bloc/favourites_bloc.dart';
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

  group("Home Page Widget Tests", () {
    testWidgets('Tests if circular progress indicator shows up',
        (tester) async {
      when(() => dogBreedsBloc.state).thenReturn(DogBreedsLoadInProgress());
      when(() => favouritesBloc.state).thenReturn(FavouritesLoading());

      await tester.pumpApp(
        dogBreedsBloc: dogBreedsBloc,
        favouritesBloc: favouritesBloc,
        child: const HomePage(),
      );

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Tests if ListView shows up', (tester) async {
      when(() => dogBreedsBloc.state)
          .thenReturn(DogBreedsLoadSuccess(BreedsCatalog(breeds)));
      when(() => favouritesBloc.state).thenReturn(FavouritesLoading());

      await tester.pumpApp(
        dogBreedsBloc: dogBreedsBloc,
        favouritesBloc: favouritesBloc,
        child: const HomePage(),
      );
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('Testing scrolling', (tester) async {
      when(() => dogBreedsBloc.state)
          .thenReturn(DogBreedsLoadSuccess(BreedsCatalog(breeds)));
      when(() => favouritesBloc.state).thenReturn(FavouritesLoading());

      await tester.pumpApp(
        dogBreedsBloc: dogBreedsBloc,
        favouritesBloc: favouritesBloc,
        child: const HomePage(),
      );

      expect(find.text('Affenpinscher'), findsOneWidget);

      await tester.fling(find.byType(ListView), const Offset(0, -200), 3000);
      await tester.pumpAndSettle();
      expect(find.text('Affenpinscher'), findsNothing);
      
    });

    testWidgets('Tests if Error Icons shows up', (tester) async {
      when(() => dogBreedsBloc.state).thenReturn(DogBreedsLoadFailure());
      when(() => favouritesBloc.state).thenReturn(FavouritesLoading());

      await tester.pumpApp(
        dogBreedsBloc: dogBreedsBloc,
        favouritesBloc: favouritesBloc,
        child: const HomePage(),
      );

      expect(find.byIcon(Icons.error), findsOneWidget);
    });
  });
}
