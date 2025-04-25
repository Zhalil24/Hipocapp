import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hipocapp/product/init/theme/custom_color_scheme.dart';
import 'package:hipocapp/product/init/theme/custom_theme.dart';

final class CustomLightTheme implements CustomTheme {
  @override
  ThemeData get themedata => ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.roboto().fontFamily,
        colorScheme: CustomColorScheme.lightColorScheme,
        scaffoldBackgroundColor: CustomColorScheme.lightColorScheme.onPrimary,
        appBarTheme: AppBarTheme(color: CustomColorScheme.lightColorScheme.primary),
        buttonTheme: ButtonThemeData(buttonColor: CustomColorScheme.lightColorScheme.primary),
        floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: CustomColorScheme.lightColorScheme.primary),
        drawerTheme: DrawerThemeData(
          backgroundColor: CustomColorScheme.lightColorScheme.surface,
        ),
        cardTheme: CardTheme(color: CustomColorScheme.lightColorScheme.surface),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconColor: MaterialStateProperty.all(CustomColorScheme.lightColorScheme.onPrimary),
          ),
        ),
      );

  @override
  final FloatingActionButtonThemeData floatingActionButtonThemeData = const FloatingActionButtonThemeData();
}
