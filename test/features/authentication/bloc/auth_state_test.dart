import 'package:dog_app/features/authentication/bloc/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthState', () {

    group('AuthState', () {
      test('supports value comparison', () {
        expect(AuthState(), AuthState());
      });
    });
    group('LoadingState', () {
      test('supports value comparison', () {
        expect(LoadingState(), LoadingState());
      });
    });

    group('AuthenticatedState', () {
      test('supports value comparison', () {
        expect(AuthenticatedState(), AuthenticatedState());
      });
    });

    group('UnAuthenticatedState', () {
      test('supports value comparison', () {
        expect(UnAuthenticatedState(), UnAuthenticatedState());
      });
    });

    group('AuthErrorState', () {
      test('supports value comparison', () {
        expect(AuthErrorState(' '), AuthErrorState(' '));
      });
    });

    group('SignOutErrorState', () {
      test('supports value comparison', () {
        expect(SignOutErrorState(' '), SignOutErrorState(' '));
      });
    });
  });
}
