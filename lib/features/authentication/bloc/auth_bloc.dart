import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:dog_app/features/authentication/data/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(UnAuthenticatedState()) {
    on<SignInRequested>((event, emit) async {
      emit(LoadingState());
      try {
        await authRepository.signIn(
            email: event.email, password: event.password);
        emit(AuthenticatedState());
      } catch (e) {
        emit(AuthErrorState(e.toString()));
        emit(UnAuthenticatedState());
      }
    });

    on<SignUpRequested>((event, emit) async{
      emit(LoadingState());
      try {
        await authRepository.signUp(
            email: event.email, password: event.password);
        emit(AuthenticatedState());
      } catch (e) {
        emit(AuthErrorState(e.toString()));
        emit(UnAuthenticatedState());
      }
    });

    on<SignOutRequested>((event, emit) async{
      emit(LoadingState());
      try {
        await authRepository.signOut();
        emit(UnAuthenticatedState());
      }
      catch (e) {
        emit(SignOutErrorState(e.toString()));
        emit(AuthenticatedState());
      }
    });
  }
}
