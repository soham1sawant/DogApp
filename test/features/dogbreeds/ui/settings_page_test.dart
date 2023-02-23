import 'package:dog_app/features/authentication/bloc/auth_bloc.dart';
import 'package:dog_app/features/dogbreeds/bloc/dogbreeds_bloc.dart';
import 'package:dog_app/features/dogbreeds/ui/settings_page.dart';
import 'package:dog_app/features/favourites/bloc/favourites_bloc.dart';
import 'package:dog_app/features/favourites/ui/widgets/badge_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helper.dart';

void main() {
  late DogBreedsBloc dogBreedsBloc;
  late AuthBloc authBloc;
  late FavouritesBloc favouritesBloc;

  setUp(() {
    dogBreedsBloc = MockDogBreedsBloc();
    authBloc = MockAuthBloc();
    favouritesBloc = MockFavouritesBloc();
  });

  group('SettingsPage', () {
    testWidgets('loads SettingsPage', (tester) async {
      when(() => dogBreedsBloc.state).thenReturn(DogBreedsLoadInProgress());
      when(() => authBloc.state).thenReturn(AuthenticatedState());
      when(() => favouritesBloc.state).thenReturn(FavouritesLoading());

      await tester.pumpApp(
        dogBreedsBloc: dogBreedsBloc,
        authBloc: authBloc,
        favouritesBloc: favouritesBloc,
        child: const SettingsPage(),
      );

      expect(find.byType(SettingsPage), findsOneWidget);
      expect(find.byType(BadgeIcon), findsNothing);
      expect(find.byKey(const Key('to-settings-page')), findsNothing);
    });
  });
}
