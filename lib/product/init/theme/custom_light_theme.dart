import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hipocapp/product/init/theme/custom_color_scheme.dart';
import 'package:hipocapp/product/init/theme/custom_theme.dart';

final class CustomLightTheme implements CustomTheme {
  @override
  ThemeData get themedata => ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.roboto().fontFamily,
        listTileTheme: const ListTileThemeData(textColor: Colors.black),
        colorScheme: CustomColorScheme.lightColorScheme,
        scaffoldBackgroundColor: CustomColorScheme.lightColorScheme.onPrimary,
        appBarTheme: AppBarTheme(
          backgroundColor: CustomColorScheme.lightColorScheme.primary,
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: CustomColorScheme.lightColorScheme.primary),
        drawerTheme: DrawerThemeData(
          backgroundColor: CustomColorScheme.lightColorScheme.onPrimary,
        ),
        cardTheme: CardThemeData(color: CustomColorScheme.lightColorScheme.surface),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconColor: WidgetStateProperty.all(
              CustomColorScheme.lightColorScheme.onPrimary,
            ),
          ),
        ),
        textTheme: GoogleFonts.robotoTextTheme().apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
          decorationColor: Colors.black,
        ),
      );

  @override
  final FloatingActionButtonThemeData floatingActionButtonThemeData = const FloatingActionButtonThemeData();
}
