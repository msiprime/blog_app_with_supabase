part of 'hydrated_theme_bloc.dart';

@immutable
sealed class HydratedThemeEvent {
  const HydratedThemeEvent();
}

final class ThemeToggledEvent extends HydratedThemeEvent {
  const ThemeToggledEvent();
}

final class DarkThemeSelectedEvent extends HydratedThemeEvent {
  const DarkThemeSelectedEvent();
}

final class LightThemeSelectedEvent extends HydratedThemeEvent {
  const LightThemeSelectedEvent();
}

final class SystemThemeSelectedEvent extends HydratedThemeEvent {
  final ThemeData themeData;

  const SystemThemeSelectedEvent({
    required this.themeData,
  });
}
