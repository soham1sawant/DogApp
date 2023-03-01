import 'package:dog_app/features/authentication/ui/delete_user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dog_app/features/authentication/bloc/auth_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helper.dart';

void main() {
  late AuthBloc authBloc;

  setUp(() {
    authBloc = MockAuthBloc();
  });

  group('DeleteUserPage', () {
    testWidgets('loads SignInPage', (tester) async {
      when(() => authBloc.state).thenReturn(UnAuthenticatedState());

      await tester.pumpApp(
        authBloc: authBloc,
        child: DeleteUserPage(),
      );

      expect(find.byType(DeleteUserPage), findsOneWidget);
      expect(
          find.byKey(const Key('delete_user_confirm_button')), findsOneWidget);
      expect(
          find.byKey(const Key('cancel_button_delete_page')), findsOneWidget);
    });

    testWidgets(
      'click CONFIRM Button when text fields are empty',
      (tester) async {
        when(() => authBloc.state).thenReturn(UnAuthenticatedState());

        await tester.pumpApp(
          authBloc: authBloc,
          child: DeleteUserPage(),
        );

        await tester.tap(find.byKey(const Key('delete_user_confirm_button')));
        await tester.pumpAndSettle();
        expect(find.text('email is required'), findsOneWidget);
        expect(find.text('password is required'), findsOneWidget);
      },
    );

    testWidgets(
      'click CONFIRM Button when wrong fields are entered',
      (tester) async {
        when(() => authBloc.state).thenReturn(UnAuthenticatedState());

        await tester.pumpApp(
          authBloc: authBloc,
          child: DeleteUserPage(),
        );

        await tester.enterText(
          find.byKey(const Key('login_email_field_deletepage')),
          'soham45@',
        );
        await tester.enterText(
          find.byKey(const Key('login_password_field_deletepage')),
          'Smashup',
        );

        await tester.tap(find.byKey(const Key('delete_user_confirm_button')));
        await tester.pumpAndSettle();

        expect(
          find.text('enter a valid email address'),
          findsOneWidget,
        );
        expect(
          find.text('password must be at least 8 digits long'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'click CONFIRM Button when correct fields are entered',
      (tester) async {
        when(() => authBloc.state).thenReturn(UnAuthenticatedState());

        await tester.pumpApp(
          authBloc: authBloc,
          child: DeleteUserPage(),
        );

        await tester.enterText(
          find.byKey(const Key('login_email_field_deletepage')),
          'sam123@gmail.com',
        );
        await tester.enterText(
          find.byKey(const Key('login_password_field_deletepage')),
          'jklsjkdlfl',
        );
        await tester.tap(find.byKey(const Key('delete_user_confirm_button')));
        verify(
          () => authBloc
              .add(const DeleteUserRequested('sam123@gmail.com', 'jklsjkdlfl')),
        );
      },
    );
  });
}
