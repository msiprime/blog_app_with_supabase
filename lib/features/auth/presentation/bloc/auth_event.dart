part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class AuthSignUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const AuthSignUpEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

class AuthSignInEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthSignInEvent({
    required this.email,
    required this.password,
  });
}

class AuthSignOutEvent extends AuthEvent {
  const AuthSignOutEvent();
}

class AuthIsUserLoggedInEvent extends AuthEvent {
  const AuthIsUserLoggedInEvent();
}
