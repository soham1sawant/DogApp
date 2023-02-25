import 'dart:core';

import 'package:authentication_repo/authentication_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationRepo authRepo;

  AuthBloc({required this.authRepo}) : super(UnAuthenticatedState()) {
    on<CheckAuthEvent>((event, emit) async {
      emit(LoadingState());

      await for (final user in authRepo.authStateSTream()) {
        if (user != null) {
          emit(AuthenticatedState());
        } else {
          emit(UnAuthenticatedState());
        }
      }
    });

    on<SignUpRequested>((event, emit) async {
      emit(LoadingState());
      try {
        await authRepo.signUp(
          email: event.email,
          password: event.password,
        );
        emit(AuthenticatedState());
      } on SignUpWithEmailAndPasswordFailure catch (e) {
        emit(AuthErrorState(e.message));
        emit(UnAuthenticatedState());
      }
    });

    on<SignInRequested>((event, emit) async {
      emit(LoadingState());
      try {
        await authRepo.signIn(
          email: event.email,
          password: event.password,
        );
        emit(AuthenticatedState());
      } on LogInWithEmailAndPasswordFailure catch (e) {
        emit(AuthErrorState(e.message));
        emit(UnAuthenticatedState());
      } catch(_) {
        emit(AuthErrorState('An unknown exception occured'));
        emit(UnAuthenticatedState());
      }
    });

    on<SignOutRequested>((event, emit) async {
      emit(LoadingState());
      try {
        await authRepo.signOut();
        emit(UnAuthenticatedState());
      } on LogOutFailure catch (e) {
        emit(SignOutErrorState(e.message));
        emit(AuthenticatedState());
      }
    });

    on<DeleteUserRequested>((event, emit) async {
      emit(LoadingState());

      try {
        await authRepo.deleteUser(event.email, event.password);
        emit(UnAuthenticatedState());
      } on UserDeleteFailure catch (e) {
        emit(UserDeleteErrorState(e.message));
        emit(AuthenticatedState());
      }
    });
  }
}
