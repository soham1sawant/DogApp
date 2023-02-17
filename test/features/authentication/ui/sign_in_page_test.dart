import 'package:dog_app/features/authentication/bloc/auth_bloc.dart';
import 'package:dog_app/features/authentication/ui/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helper.dart';

void loadSignInPageCheck() {
  expect(find.byType(SignInPage), findsOneWidget);
  expect(find.byKey(const Key('log_in_button')), findsOneWidget);
  expect(find.byKey(const Key('sign_up_page_button')), findsOneWidget);
}

void main() {
  late AuthBloc authBloc;

  setUpAll(() {
    registerFallbackValue(FakeRoute());
  });

  setUp(() {
    authBloc = MockAuthBloc();
  });

  group('SignInPage', () {
    testWidgets('loads SignInPage', (tester) async {
      when(() => authBloc.state).thenReturn(UnAuthenticatedState());

      await tester.pumpApp(
        authBloc: authBloc,
        child: SignInPage(),
      );

      loadSignInPageCheck();
    });

    testWidgets(
      'clicked SIGN IN Button when text fields are empty',
      (tester) async {
        when(() => authBloc.state).thenReturn(UnAuthenticatedState());

        await tester.pumpApp(
          authBloc: authBloc,
          child: SignInPage(),
        );

        await tester.tap(find.byKey(const Key('log_in_button')));
        await tester.pumpAndSettle();
        expect(find.text('email is required'), findsOneWidget);
        expect(find.text('password is required'), findsOneWidget);
      },
    );

    testWidgets(
      'clicked SIGN IN Button when wrong fields are entered',
      (tester) async {
        when(() => authBloc.state).thenReturn(UnAuthenticatedState());

        await tester.pumpApp(
          authBloc: authBloc,
          child: SignInPage(),
        );

        await tester.enterText(
          find.byKey(const Key('login_email_field')),
          'soham45@',
        );
        await tester.enterText(
          find.byKey(const Key('login_password_field')),
          'Smashup',
        );
        await tester.tap(find.byKey(const Key('log_in_button')));
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
      'clicked SIGN IN Button when correct fields are entered',
      (tester) async {
        when(() => authBloc.state).thenReturn(UnAuthenticatedState());

        await tester.pumpApp(
          authBloc: authBloc,
          child: SignInPage(),
        );

        await tester.enterText(
          find.byKey(const Key('login_email_field')),
          'sam123@gmail.com',
        );
        await tester.enterText(
          find.byKey(const Key('login_password_field')),
          'jklsjkdlfl',
        );
        await tester.tap(find.byKey(const Key('log_in_button')));
        verify(
          () => authBloc
              .add(const SignInRequested('sam123@gmail.com', 'jklsjkdlfl')),
        );
      },
    );
  });
}
