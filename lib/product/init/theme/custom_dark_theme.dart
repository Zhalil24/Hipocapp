import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_architecture_template/product/init/theme/custom_color_scheme.dart';
import 'package:my_architecture_template/product/init/theme/custom_theme.dart';

final class CustomDarkTheme implements CustomTheme {
  // TODO: change to initialize  Themdata instead of computed
  @override
  ThemeData get themedata => ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.roboto().fontFamily,
        scaffoldBackgroundColor: CustomColorScheme.darkColorScheme.primary,
        colorScheme: CustomColorScheme.darkColorScheme,
        textTheme: ThemeData.dark().textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
              decorationColor: Colors.white,
            ),
      );
  @override
  final FloatingActionButtonThemeData floatingActionButtonThemeData = const FloatingActionButtonThemeData();
}
