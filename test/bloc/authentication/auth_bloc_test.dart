import 'package:bloc_test/bloc_test.dart';
import 'package:dog_app/bloc/authentication/auth_bloc.dart';
import 'package:dog_app/data/repositories/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group("AuthBloc", () {
    late AuthRepository authRepository;

    setUp(() {
      authRepository = MockAuthRepository();
    });

    test("initial state is UnAutheticatedState", () {
      expect(AuthBloc(authRepository: authRepository).state,
          UnAuthenticatedState());
    });

    blocTest<AuthBloc, AuthState>(
      "emits [LoadingState, AuthenticatedState]"
      "when user is signed in successfully",
      setUp: () {
        when(() => authRepository.signIn(email: "", password: ""))
            .thenAnswer((_) async {});
      },
      build: () => AuthBloc(authRepository: authRepository),
      seed: () => UnAuthenticatedState(),
      act: (bloc) => bloc.add(const SignInRequested("", "")),
      expect: () => <AuthState>[LoadingState(), AuthenticatedState()],
      verify: (_) {
        verify(() => authRepository.signIn(email: "", password: "")).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      "emits [LoadingState, AuthErrorState, UnAuthenticatedState]"
      "when user is not signed in",
      setUp: () {
        when(() => authRepository.signIn(email: "", password: ""))
            .thenThrow("Error");
      },
      build: () => AuthBloc(authRepository: authRepository),
      seed: () => UnAuthenticatedState(),
      act: (bloc) => bloc.add(const SignInRequested("", "")),
      expect: () => <AuthState>[
        LoadingState(),
        const AuthErrorState("Error"),
        UnAuthenticatedState()
      ],
      verify: (_) {
        verify(() => authRepository.signIn(email: "", password: "")).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      "emits [LoadingState, AuthenticatedState]"
      "when user is signed up successfully",
      setUp: () {
        when(() => authRepository.signUp(email: "", password: ""))
            .thenAnswer((_) async {});
      },
      build: () => AuthBloc(authRepository: authRepository),
      seed: () => UnAuthenticatedState(),
      act: (bloc) => bloc.add(const SignUpRequested("", "")),
      expect: () => <AuthState>[LoadingState(), AuthenticatedState()],
      verify: (_) {
        verify(() => authRepository.signUp(email: "", password: "")).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      "emits [LoadingState, AuthErrorState, UnAuthenticatedState]"
      "when user is not signed up",
      setUp: () {
        when(() => authRepository.signUp(email: "", password: ""))
            .thenThrow("Error");
      },
      build: () => AuthBloc(authRepository: authRepository),
      seed: () => UnAuthenticatedState(),
      act: (bloc) => bloc.add(const SignUpRequested("", "")),
      expect: () => <AuthState>[
        LoadingState(),
        const AuthErrorState("Error"),
        UnAuthenticatedState()
      ],
      verify: (_) {
        verify(() => authRepository.signUp(email: "", password: "")).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      "emits [LoadingState, UnAuthenticatedState]"
      "when user signs out successfully",
      setUp: () {
        when(() => authRepository.signOut()).thenAnswer((_) async {});
      },
      build: () => AuthBloc(authRepository: authRepository),
      seed: () => AuthenticatedState(),
      act: (bloc) => bloc.add(const SignOutRequested()),
      expect: () => <AuthState>[LoadingState(), UnAuthenticatedState()],
      verify: (_) {
        verify(() => authRepository.signOut()).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      "emits [SignOutErrorState, AuthenticatedState]"
      "when user is not signed out",
      setUp: () {
        when(() => authRepository.signOut()).thenThrow("Error");
      },
      build: () => AuthBloc(authRepository: authRepository),
      seed: () => AuthenticatedState(),
      act: (bloc) => bloc.add(const SignOutRequested()),
      expect: () => <AuthState>[LoadingState(), const SignOutErrorState("Error"), AuthenticatedState()],
      verify: (_) {
        verify(() => authRepository.signOut()).called(1);
      },
    );
  });
}
