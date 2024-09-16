part of 'hydrated_theme_bloc.dart';

@immutable
sealed class HydratedThemeState {
  const HydratedThemeState();
}

final class HydratedThemeInitial extends HydratedThemeState {
  const HydratedThemeInitial();
}

final class ThemeChanged extends HydratedThemeState {
  final ThemeData themeData;

  const ThemeChanged({
    required this.themeData,
  });
}
