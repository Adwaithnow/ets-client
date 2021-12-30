import 'package:flutter/material.dart';
import 'package:test_app/themes/lightColors.dart';

//ThemeData lightTheme = CustomTheme();
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  backgroundColor: background,
  primaryColor: primary,
  colorScheme: const ColorScheme(
    primary: primary,
    background: background,
    secondary: secondary,
    surface: surface,
    error: error,
    primaryVariant: primaryVariant,
    secondaryVariant: secondaryVariant,
    onPrimary: onPrimary,
    onBackground: onBackground,
    onSecondary: onSecondary,
    onSurface: onSurface,
    onError: onError,
    brightness: Brightness.light,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
    ),
  ),
);