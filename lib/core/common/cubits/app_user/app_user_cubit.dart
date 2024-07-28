import 'package:capestone_test/core/common/entities/profile_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(const AppUserInitial());

  void updateUser(ProfileEntity? user) {
    if (user != null) {
      emit(AppUserLoggedIn(profileEntity: user));
    } else {
      emit(const AppUserInitial());
    }
  }
}
