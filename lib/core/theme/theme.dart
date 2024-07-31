import 'package:flutter/material.dart';

import 'app_pallete.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(fontSize: 18),
      centerTitle: true,
      backgroundColor: AppPallete.backgroundColor,
    ),
    chipTheme: const ChipThemeData(
      color: WidgetStatePropertyAll(AppPallete.backgroundColor),
      side: BorderSide.none,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient2),
      errorBorder: _border(AppPallete.errorColor),
    ),
  );

  static final lightThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppPallete.lightBackgroundColor,
    primaryColor: AppPallete.lightPrimaryColor,
    hintColor: AppPallete.lightTextColor,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(fontSize: 18, color: AppPallete.lightTextColor),
      centerTitle: true,
      backgroundColor: AppPallete.lightBackgroundColor,
      iconTheme: IconThemeData(color: AppPallete.lightTextColor),
    ),
    chipTheme: const ChipThemeData(
      backgroundColor: AppPallete.lightBackgroundColor,
      side: BorderSide.none,
      labelStyle: TextStyle(color: AppPallete.lightTextColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      border: _border(AppPallete.lightBorderColor),
      enabledBorder: _border(AppPallete.lightBorderColor),
      focusedBorder: _border(AppPallete.lightPrimaryColor),
      errorBorder: _border(AppPallete.errorColor),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppPallete.lightTextColor),
      bodyMedium: TextStyle(color: AppPallete.lightTextColor),
    ),
    cardColor: AppPallete.lightBackgroundColor,
    iconTheme: const IconThemeData(color: AppPallete.lightTextColor),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppPallete.lightPrimaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}

