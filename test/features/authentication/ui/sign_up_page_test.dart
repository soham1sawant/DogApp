import 'package:dog_app/features/authentication/bloc/auth_bloc.dart';
import 'package:dog_app/features/authentication/ui/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helper.dart';

void loadSignUpPageCheck() {
  expect(find.byType(SignUpPage), findsOneWidget);
  expect(find.byKey(const Key('sign_up_button')), findsOneWidget);
  expect(find.byKey(const Key('log_in_page_button')), findsOneWidget);
}

Future<void> emptyFieldsSignUpButtonClicked(WidgetTester tester) async {
  await tester.tap(find.byKey(const Key('sign_up_button')));
  await tester.pumpAndSettle();
  expect(find.text('email is required'), findsOneWidget);
  expect(find.text('password is required'), findsOneWidget);
}

Future<void> wrongFieldsSignUpButtonClicked(WidgetTester tester) async {
  // entered wrong email and password smaller than 8 characters
  await tester.enterText(
    find.byKey(const Key('signup_email_field')),
    'jlkdfjld',
  );
  await tester.enterText(
    find.byKey(const Key('signup_password1_field')),
    'dkghiek',
  );
  await tester.tap(find.byKey(const Key('sign_up_button')));
  await tester.pumpAndSettle();
  expect(find.text('enter a valid email address'), findsOneWidget);
  expect(
    find.text('password must be at least 8 digits long'),
    findsOneWidget,
  );
  expect(find.text('Passwords do not match!'), findsOneWidget);

  // entered password longer than 8 characters without special character and
  // numbers
  await tester.enterText(
    find.byKey(const Key('signup_password1_field')),
    'dkghiekjfkdfljdh',
  );
  await tester.tap(find.byKey(const Key('sign_up_button')));
  await tester.pumpAndSettle();
  expect(
    find.text('at least one special character required'),
    findsOneWidget,
  );
  expect(find.text('Passwords do not match!'), findsOneWidget);

  // entered password longer than 8 characters with special character and
  // without number
  await tester.enterText(
    find.byKey(const Key('signup_password1_field')),
    'dkghiekjfkdfljdh?!',
  );
  await tester.tap(find.byKey(const Key('sign_up_button')));
  await tester.pumpAndSettle();
  expect(find.text('at least one number required'), findsOneWidget);
  expect(find.text('Passwords do not match!'), findsOneWidget);

  // entered password longer than 8 characters with special character and
  // with number but passwords do not mactch
  await tester.enterText(
    find.byKey(const Key('signup_password1_field')),
    'dkghiekjfkdfljdh?!23',
  );
  await tester.tap(find.byKey(const Key('sign_up_button')));
  await tester.pumpAndSettle();
  expect(find.text('Passwords do not match!'), findsOneWidget);

  // entered password correct but both do not match
  await tester.enterText(
    find.byKey(const Key('signup_password1_field')),
    'dkghiekjfkdfljdh?!23',
  );
  await tester.enterText(
    find.byKey(const Key('signup_password2_field')),
    'dkghiekjfkdfljdh?!24',
  );
  await tester.tap(find.byKey(const Key('sign_up_button')));
  await tester.pumpAndSettle();
  expect(find.text('Passwords do not match!'), findsOneWidget);
}

Future<void> correctFieldsSignUpButtonClicked(WidgetTester tester) async {
  await tester.enterText(
    find.byKey(const Key('signup_email_field')),
    'krishnav@gmail.com',
  );
  await tester.enterText(
    find.byKey(const Key('signup_password1_field')),
    'dkghiekjfkdfljdh?!23',
  );
  await tester.enterText(
    find.byKey(const Key('signup_password2_field')),
    'dkghiekjfkdfljdh?!23',
  );
  await tester.tap(find.byKey(const Key('sign_up_button')));
}

void main() {
  late AuthBloc authBloc;

  setUp(() {
    authBloc = MockAuthBloc();
  });

  group('SignUpPage', () {
    testWidgets('loads SignUpPage', (tester) async {
      when(() => authBloc.state).thenReturn(UnAuthenticatedState());

      await tester.pumpApp(
        authBloc: authBloc,
        child: SignUpPage(),
      );

      loadSignUpPageCheck();
    });
  });

  testWidgets(
    'clicked SIGN UP Button when text fields are empty',
    (tester) async {
      when(() => authBloc.state).thenReturn(UnAuthenticatedState());

      await tester.pumpApp(
        authBloc: authBloc,
        child: SignUpPage(),
      );

      await emptyFieldsSignUpButtonClicked(tester);
    },
  );

  testWidgets(
    'clicked SIGN UP Button when wrong email and password entered',
    (tester) async {
      when(() => authBloc.state).thenReturn(UnAuthenticatedState());

      await tester.pumpApp(
        authBloc: authBloc,
        child: SignUpPage(),
      );

      await wrongFieldsSignUpButtonClicked(tester);
    },
  );

  testWidgets(
    'clicked SIGN UP Button when text fields are correct',
    (tester) async {
      when(() => authBloc.state).thenReturn(UnAuthenticatedState());

      await tester.pumpApp(
        authBloc: authBloc,
        child: SignUpPage(),
      );

      await correctFieldsSignUpButtonClicked(tester);

      verify(
        () => authBloc.add(
          const SignUpRequested(
            'krishnav@gmail.com',
            'dkghiekjfkdfljdh?!23',
          ),
        ),
      );
    },
  );
}
