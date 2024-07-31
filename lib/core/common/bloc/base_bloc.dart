import 'dart:async';

import 'package:capestone_test/core/services/local_storage/cache_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'base_event.dart';
import 'base_state.dart';

class BaseBloc extends Bloc<BaseEvent, BaseState> {
  BaseBloc() : super(const BaseState.initial()) {
    on<ChangeThemeEvent>(_changeThemeState);
  }

  FutureOr<void> _changeThemeState(
    ChangeThemeEvent event,
    Emitter<BaseState> emit,
  ) {
    emit((state.copyWith(themeMode: event.themeMode)));
    CacheService.instance.changeTheme(event.themeMode ?? ThemeMode.dark);
  }
}
