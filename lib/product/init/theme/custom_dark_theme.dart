import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hipocapp/product/init/theme/custom_color_scheme.dart';
import 'package:hipocapp/product/init/theme/custom_theme.dart';

final class CustomDarkTheme implements CustomTheme {
  @override
  ThemeData get themedata => ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.roboto().fontFamily,
        scaffoldBackgroundColor: CustomColorScheme.darkColorScheme.onPrimary,
        colorScheme: CustomColorScheme.darkColorScheme,
        appBarTheme: AppBarTheme(
          backgroundColor: CustomColorScheme.darkColorScheme.primary,
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        listTileTheme: const ListTileThemeData(
          textColor: Colors.white,
          iconColor: Colors.white,
        ),
        textTheme: GoogleFonts.robotoTextTheme().apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
          decorationColor: Colors.white,
        ),
        cardTheme: CardThemeData(color: CustomColorScheme.darkColorScheme.tertiary),
        floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: CustomColorScheme.darkColorScheme.primary),
        drawerTheme: DrawerThemeData(
          backgroundColor: CustomColorScheme.darkColorScheme.tertiary,
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconColor: WidgetStateProperty.all(
              CustomColorScheme.lightColorScheme.onPrimary,
            ),
          ),
        ),
      );
  @override
  final FloatingActionButtonThemeData floatingActionButtonThemeData = const FloatingActionButtonThemeData();
}
