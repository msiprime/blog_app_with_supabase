part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {
  const AppUserState();
}

final class AppUserInitial extends AppUserState {
  const AppUserInitial();
}

final class AppUserLoggedIn extends AppUserState {
  final ProfileEntity profileEntity;

  const AppUserLoggedIn({
    required this.profileEntity,
  });
}
