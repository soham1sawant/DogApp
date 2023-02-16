import 'package:dog_app/features/authentication/bloc/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthEvent', () {
    group('CheckAuthEvent', () {
      test('supports value comparison', () {
        expect(const CheckAuthEvent(), const CheckAuthEvent());
      });
    });
    group('SignInRequested', () {
      test('supports value comparison', () {
        expect(
          const SignInRequested(' ', ' '),
          const SignInRequested(' ', ' '),
        );
      });
    });

    group('SignUpRequested', () {
      test('supports value comparison', () {
        expect(
          const SignUpRequested(' ', ' '),
          const SignUpRequested(' ', ' '),
        );
      });
    });

    group('SignOutRequested', () {
      test('supports value comparison', () {
        expect(const SignOutRequested(), const SignOutRequested());
      });
    });
  });
}
