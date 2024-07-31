import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum AppStatus { initial, loading, failed, success }

class BaseState extends Equatable {
  final AppStatus? status;
  final ThemeMode? themeMode;

  const BaseState({this.status, this.themeMode});

  const BaseState.initial()
      : status = AppStatus.initial,
        themeMode = ThemeMode.light;

  BaseState copyWith({
    AppStatus? appStatus,
    ThemeMode? themeMode,
  }) {
    return BaseState(
      status: status ?? status,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object?> get props => [status, themeMode];
}
