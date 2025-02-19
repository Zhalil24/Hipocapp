import 'package:flutter/material.dart';
import 'package:my_architecture_template/product/init/theme/custom_color_scheme.dart';
import 'package:my_architecture_template/product/init/theme/custom_theme.dart';

final class CustomDarkTheme implements CustomTheme {
  // TODO: change to initialize  Themdata instead of computed
  @override
  ThemeData get themedata => ThemeData(
        useMaterial3: true,
        colorScheme: CustomColorScheme.darkColorScheme,
      );
  @override
  final FloatingActionButtonThemeData floatingActionButtonThemeData = const FloatingActionButtonThemeData();
}
