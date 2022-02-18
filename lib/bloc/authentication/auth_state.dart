part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class LoadingState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthenticatedState extends AuthState {
  @override
  List<Object> get props => [];
}

class UnAuthenticatedState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthErrorState extends AuthState {
  final String error;

  const AuthErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class SignOutErrorState extends AuthState {
  final String error;

  const SignOutErrorState(this.error);


  @override
  List<Object> get props => [error];
}