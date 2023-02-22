import 'package:bloc_test/bloc_test.dart';
import 'package:dog_app/features/authentication/bloc/auth_bloc.dart';
import 'package:authentication_repo/authentication_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthenticationRepo {}

void main() {
  group('AuthBloc', () {
    late AuthenticationRepo authRepository;

    setUp(() {
      authRepository = MockAuthRepository();
    });

    test('initial state is UnAutheticatedState', () {
      expect(
        AuthBloc(authRepo: authRepository).state,
        UnAuthenticatedState(),
      );
    });

    blocTest<AuthBloc, AuthState>(
      'emits [LoadingState, AuthenticatedState] '
      'when user is signed in successfully',
      setUp: () {
        when(() => authRepository.signIn(email: '', password: ''))
            .thenAnswer((_) async {});
      },
      build: () => AuthBloc(authRepo: authRepository),
      seed: UnAuthenticatedState.new,
      act: (bloc) => bloc.add(const SignInRequested('', '')),
      expect: () => <AuthState>[LoadingState(), AuthenticatedState()],
      verify: (_) {
        verify(() => authRepository.signIn(email: '', password: '')).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [LoadingState, AuthErrorState, UnAuthenticatedState] '
      'when user is not signed in',
      setUp: () {
        when(() => authRepository.signIn(email: '', password: ''))
            .thenThrow(const LogInWithEmailAndPasswordFailure());
      },
      build: () => AuthBloc(authRepo: authRepository),
      seed: UnAuthenticatedState.new,
      act: (bloc) => bloc.add(const SignInRequested('', '')),
      expect: () => <AuthState>[
        LoadingState(),
        AuthErrorState('An unknown exception occured'),
        UnAuthenticatedState()
      ],
      verify: (_) {
        verify(() => authRepository.signIn(email: '', password: '')).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [LoadingState, AuthenticatedState] '
      'when user is signed up successfully',
      setUp: () {
        when(() => authRepository.signUp(email: '', password: ''))
            .thenAnswer((_) async {});
      },
      build: () => AuthBloc(authRepo: authRepository),
      seed: UnAuthenticatedState.new,
      act: (bloc) => bloc.add(const SignUpRequested('', '')),
      expect: () => <AuthState>[LoadingState(), AuthenticatedState()],
      verify: (_) {
        verify(() => authRepository.signUp(email: '', password: '')).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [LoadingState, AuthErrorState, UnAuthenticatedState] '
      'when user is not signed up',
      setUp: () {
        when(() => authRepository.signUp(email: '', password: ''))
            .thenThrow(const SignUpWithEmailAndPasswordFailure());
      },
      build: () => AuthBloc(authRepo: authRepository),
      seed: UnAuthenticatedState.new,
      act: (bloc) => bloc.add(const SignUpRequested('', '')),
      expect: () => <AuthState>[
        LoadingState(),
        AuthErrorState('An unknown exception occured'),
        UnAuthenticatedState()
      ],
      verify: (_) {
        verify(() => authRepository.signUp(email: '', password: '')).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [LoadingState, UnAuthenticatedState] '
      'when user signs out successfully',
      setUp: () {
        when(() => authRepository.signOut()).thenAnswer((_) async {});
      },
      build: () => AuthBloc(authRepo: authRepository),
      seed: AuthenticatedState.new,
      act: (bloc) => bloc.add(const SignOutRequested()),
      expect: () => <AuthState>[LoadingState(), UnAuthenticatedState()],
      verify: (_) {
        verify(() => authRepository.signOut()).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [SignOutErrorState, AuthenticatedState] '
      'when user is not signed out',
      setUp: () {
        when(() => authRepository.signOut()).thenThrow(const LogOutFailure());
      },
      build: () => AuthBloc(authRepo: authRepository),
      seed: AuthenticatedState.new,
      act: (bloc) => bloc.add(const SignOutRequested()),
      expect: () => <AuthState>[
        LoadingState(),
        SignOutErrorState('Error caused. Retry Signing Out'),
        AuthenticatedState(),
      ],
      verify: (_) {
        verify(() => authRepository.signOut()).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [MyState] when MyEvent is added.',
      build: () => AuthBloc(authRepo: authRepository),
      act: (bloc) => bloc.add(MyEvent),
      expect: () => const <AuthState>[MyState],
    );
  });
}
