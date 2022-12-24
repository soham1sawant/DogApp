import 'package:dog_app/core/widgets/main_header.dart';
import 'package:dog_app/features/favourites/bloc/favourites_bloc.dart';
import 'package:dog_app/features/favourites/models/favourites_list.dart';
import 'package:dog_app/features/favourites/ui/favourites_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/favbreeds_data.dart';
import '../../../helpers/helper.dart';

void main() {
  late FavouritesBloc favouritesBloc;

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
    testWidgets('Tests if Main Header shows up', (tester) async {
      when(() => favouritesBloc.state).thenReturn(FavouritesLoading());
        await tester.pumpApp(
          favouritesBloc: favouritesBloc,
          child: const FavouritesPage(),
        );

      expect(find.byType(MainHeader), findsOneWidget);
    });
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
