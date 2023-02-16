part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CheckAuthEvent extends AuthEvent {
  const CheckAuthEvent();

  @override
  List<Object> get props => [];
}
class SignUpRequested extends AuthEvent {

  const SignUpRequested(this.email, this.password);
  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class SignInRequested extends AuthEvent {

  const SignInRequested(this.email, this.password);
  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class SignOutRequested extends AuthEvent {
  const SignOutRequested();

  @override
  List<Object> get props => [];
}
