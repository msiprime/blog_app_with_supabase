import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'hydrated_theme_event.dart';
part 'hydrated_theme_state.dart';

class HydratedThemeBloc extends Bloc<HydratedThemeEvent, HydratedThemeState> {
  HydratedThemeBloc() : super(HydratedThemeInitial()) {
    on<HydratedThemeEvent>(_onHydratedThemeEvent);
    on<DarkThemeSelectedEvent>(_onDarkThemeSelectedEvent);
    on<LightThemeSelectedEvent>(_onLightThemeSelectedEvent);
    on<SystemThemeSelectedEvent>(_onSystemThemeSelectedEvent);
  }

  FutureOr<void> _onHydratedThemeEvent(event, emit) {
    // TODO: implement event handler
  }

  FutureOr<void> _onDarkThemeSelectedEvent(
      DarkThemeSelectedEvent event, Emitter<HydratedThemeState> emit) {
    emit(ThemeChanged(themeData: ThemeData.dark()));
  }

  FutureOr<void> _onLightThemeSelectedEvent(
      LightThemeSelectedEvent event, Emitter<HydratedThemeState> emit) {
    emit(ThemeChanged(themeData: ThemeData.light()));
  }

  FutureOr<void> _onSystemThemeSelectedEvent(
      SystemThemeSelectedEvent event, Emitter<HydratedThemeState> emit) {}
}
