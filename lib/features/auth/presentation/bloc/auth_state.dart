part of 'auth_bloc.dart';

abstract class AuthState {
  const AuthState();

  get profileEntityDetails => null;
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSuccess extends AuthState {
  final ProfileEntity profileEntity;

  const AuthSuccess(
    this.profileEntity,
  );

  @override
  String get profileEntityDetails =>
      'ProfileEntity: ${profileEntity.name}, ${profileEntity.email}, ${profileEntity.id}';
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(
    this.message,
  );
}
