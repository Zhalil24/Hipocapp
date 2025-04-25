import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hipocapp/product/init/theme/custom_color_scheme.dart';
import 'package:hipocapp/product/init/theme/custom_theme.dart';

final class CustomDarkTheme implements CustomTheme {
  // TODO: change to initialize  Themdata instead of computed
  @override
  ThemeData get themedata => ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.roboto().fontFamily,
        scaffoldBackgroundColor: CustomColorScheme.darkColorScheme.surface,
        colorScheme: CustomColorScheme.darkColorScheme,
        appBarTheme: AppBarTheme(color: CustomColorScheme.darkColorScheme.primary),
        listTileTheme: const ListTileThemeData(
          textColor: Colors.white,
          iconColor: Colors.white,
        ),
        textTheme: ThemeData.dark().textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
              decorationColor: Colors.white,
            ),
        cardTheme: CardTheme(color: CustomColorScheme.darkColorScheme.tertiary),
        floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: CustomColorScheme.darkColorScheme.primary),
        drawerTheme: DrawerThemeData(backgroundColor: CustomColorScheme.darkColorScheme.tertiary),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconColor: MaterialStateProperty.all(CustomColorScheme.darkColorScheme.onPrimary),
          ),
        ),
      );
  @override
  final FloatingActionButtonThemeData floatingActionButtonThemeData = const FloatingActionButtonThemeData();
}
