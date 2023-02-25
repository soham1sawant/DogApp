import 'package:dog_app/features/authentication/ui/sign_in_page.dart';
import 'package:dog_app/features/authentication/ui/sign_up_page.dart';
import 'package:dog_app/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../test/features/authentication/ui/sign_in_page_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end to end test', () {
    testWidgets('runs through full app', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      loadSignInPageCheck();

      await Future.delayed(const Duration(seconds: 3));

      // log in button clicked when fields are empty
      await tester.tap(find.byKey(const Key('log_in_button')));
      await tester.pumpAndSettle();
      expect(find.text('email is required'), findsOneWidget);
      expect(find.text('password is required'), findsOneWidget);

      await Future.delayed(const Duration(seconds: 3));

      // log in button clicked when wrong fields are entered
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

      await Future.delayed(const Duration(seconds: 3));

      // log in button clicked when correct fields are entered
      await tester.enterText(
        find.byKey(const Key('login_email_field')),
        'sam123@gmail.com',
      );
      await tester.enterText(
        find.byKey(const Key('login_password_field')),
        'jklsjkdlfl',
      );
      await tester.tap(find.byKey(const Key('log_in_button')));
      await tester.pumpAndSettle();

      expect(find.byType(SignInPage), findsOneWidget);

      //navigates to sign up page
      await tester.tap(find.byKey(const Key('sign_up_page_button')));
      await tester.pumpAndSettle();

      expect(find.byType(SignUpPage), findsOneWidget);

      await Future.delayed(const Duration(seconds: 3));

    });
  });
}
