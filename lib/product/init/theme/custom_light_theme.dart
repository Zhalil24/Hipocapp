import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_architecture_template/product/init/theme/custom_color_scheme.dart';
import 'package:my_architecture_template/product/init/theme/custom_theme.dart';

final class CustomLightTheme implements CustomTheme {
  @override
  ThemeData get themedata => ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.roboto().fontFamily,
        colorScheme: CustomColorScheme.lightColorScheme,
        scaffoldBackgroundColor: CustomColorScheme.darkColorScheme.primary,
      );

  @override
  final FloatingActionButtonThemeData floatingActionButtonThemeData = const FloatingActionButtonThemeData();
}
