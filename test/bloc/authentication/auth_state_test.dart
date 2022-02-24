import 'package:dog_app/bloc/authentication/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("AuthState", () {
    group("LoadingState", () {
      test('supports value comparison', () {
        expect(LoadingState(), LoadingState());
      });
    });

    group("AuthenticatedState", () {
      test('supports value comparison', () {
        expect(AuthenticatedState(), AuthenticatedState());
      });
    });

    group("UnAuthenticatedState", () {
      test('supports value comparison', () {
        expect(UnAuthenticatedState(), UnAuthenticatedState());
      });
    });

    group("AuthErrorState", () {
      test('supports value comparison', () {
        expect(const AuthErrorState(" "), const AuthErrorState(" "));
      });
    });

    group("SignOutErrorState", () {
      test('supports value comparison', () {
        expect(const SignOutErrorState(" "), const SignOutErrorState(" "));
      });
    });
  });
}