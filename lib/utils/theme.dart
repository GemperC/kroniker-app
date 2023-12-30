import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stroke_text/stroke_text.dart';

class AppColors {
  // static final AppTheme colors = ColorPalette._();
  AppColors._();

  // Light Theme Color Scheme
  static final ColorScheme lightColorScheme = ColorScheme.light(
    background: Colors.white,
    primary: Colors.blue,
    onPrimary: Colors.black,
  );

  // Dark Theme Color Scheme
  static final ColorScheme darkColorScheme = ColorScheme.dark(
    background: Color.fromARGB(255, 0, 0, 0),
    primary: Colors.blue,
    onPrimary: Colors.white,
    secondary: Color.fromARGB(15, 32, 32, 32),
    surfaceTint: Color.fromARGB(15, 59, 59, 59),
  );

  // Light Theme
  static final ThemeData LightTheme = ThemeData(
    colorScheme: lightColorScheme,
    scaffoldBackgroundColor: lightColorScheme.background,
  );

  // Dark Theme
  static final ThemeData DarkTheme = ThemeData(
    colorScheme: darkColorScheme,
    scaffoldBackgroundColor: darkColorScheme.background,
  );
}

class AppTypography {
  static const _defaultFontFamily = 'Open Sans';

  AppTypography._();

  static TextStyle characterCardText(BuildContext context) => gameCardText(context);

  static TextStyle floatingButtonText(BuildContext context) =>
      GoogleFonts.getFont(
        _defaultFontFamily,
        color: Theme.of(context)
            .colorScheme
            .onBackground, // Adapted to current theme
        fontWeight: FontWeight.w800,
        fontSize: 16.0,
      );

  static TextStyle title(BuildContext context) => GoogleFonts.getFont(
        _defaultFontFamily,
        color: Theme.of(context)
            .colorScheme
            .onBackground, // Adapted to current theme
        fontWeight: FontWeight.w600,
        fontSize: 25.0,
      );

  static TextStyle gameCardText(BuildContext context) =>
      GoogleFonts.getFont(_defaultFontFamily,
          color: Theme.of(context)
              .colorScheme
              .onBackground, // Adapted to current theme
          fontWeight: FontWeight.w600,
          fontSize: 22.0,
          letterSpacing: 1.8);

  static TextStyle dialogTitle(BuildContext context) => GoogleFonts.getFont(
        _defaultFontFamily,
        color: Theme.of(context)
            .colorScheme
            .onBackground, // Adapted to current theme
        fontWeight: FontWeight.w600,
        fontSize: 25.0,
      );

  static TextStyle bannerTitle(BuildContext context) => GoogleFonts.getFont(
        _defaultFontFamily,
        color: Theme.of(context)
            .colorScheme
            .onBackground, // Adapted to current theme
        fontWeight: FontWeight.w600,
        fontSize: 30.0,
      );
  static TextStyle appTitle(BuildContext context) => GoogleFonts.getFont(
        _defaultFontFamily,
        color: Theme.of(context)
            .colorScheme
            .onBackground, // Adapted to current theme
        fontWeight: FontWeight.w900,
        fontSize: 60.0,
      );

  static TextStyle textfieldText(BuildContext context) => GoogleFonts.getFont(
        _defaultFontFamily,
        color: Theme.of(context).colorScheme.onSurface,
        fontWeight: FontWeight.w600,
        fontSize: 22.0,
      );

  static TextStyle textfieldHintText(BuildContext context) =>
      GoogleFonts.getFont(
        _defaultFontFamily,
        color: Theme.of(context).hintColor,
        fontWeight: FontWeight.w600,
        fontSize: 22.0,
      );

  static TextStyle buttonText(BuildContext context) => GoogleFonts.getFont(
        _defaultFontFamily,
        color: Theme.of(context).colorScheme.onPrimary,
        fontWeight: FontWeight.w600,
        fontSize: 22.0,
      );
  static TextStyle buttonTextS(BuildContext context) => GoogleFonts.getFont(
        _defaultFontFamily,
        color: Theme.of(context).colorScheme.onPrimary,
        fontWeight: FontWeight.w600,
        fontSize: 14.0,
      );
}
