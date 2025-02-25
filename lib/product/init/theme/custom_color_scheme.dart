import 'package:flutter/material.dart';

/// Project Custom Color
final class CustomColorScheme {
  CustomColorScheme._();

  /// Light Color Scheme
  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFFFFC107), // Sarı (Amber)
    surfaceTint: Color(0xFFFFD54F), // Açık sarı yüzey
    onPrimary: Colors.white, // Beyaz yazı
    primaryContainer: Color(0xFFFFE082), // Hafif sarı
    onPrimaryContainer: Colors.black, // Siyah yazı

    secondary: Color(0xFFFFA000), // Turuncu
    onSecondary: Colors.white,
    secondaryContainer: Color(0xFFFFB74D),
    onSecondaryContainer: Colors.black,

    tertiary: Color(0xFFFFD700), // Daha parlak sarı
    onTertiary: Colors.black,
    tertiaryContainer: Color(0xFFFFE57F),
    onTertiaryContainer: Colors.black,

    error: Color(0xFFD32F2F), // Kırmızı hata rengi
    onError: Colors.white,
    errorContainer: Color(0xFFF44336),
    onErrorContainer: Colors.black,

    surface: Color(0xFFFFF8E1), // Çok açık sarı arka plan
    onSurface: Colors.black,
    onSurfaceVariant: Color(0xFF757575),
    outline: Color(0xFFBDBDBD),

    shadow: Colors.black45,
    scrim: Colors.black54,
    inverseSurface: Color(0xFF303030), // Koyu gri
    inversePrimary: Colors.black, // Siyah
  );

  /// Dark Color Scheme
  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFFFD700), // Altın sarısı
    surfaceTint: Color(0xFFFFA000), // Turuncu sarı
    onPrimary: Colors.black, // Siyah yazılar
    primaryContainer: Color(0xFFFFD54F),
    onPrimaryContainer: Colors.black,

    secondary: Color(0xFFFFC107), // Sarı
    onSecondary: Colors.black,
    secondaryContainer: Color(0xFFFFD54F),
    onSecondaryContainer: Colors.black,

    tertiary: Color(0xFFFFA000), // Turuncu vurgu
    onTertiary: Colors.black,
    tertiaryContainer: Color(0xFFFFD54F),
    onTertiaryContainer: Colors.black,

    error: Color(0xFFB71C1C), // Koyu kırmızı
    onError: Colors.white,
    errorContainer: Color(0xFFD32F2F),
    onErrorContainer: Colors.black,

    surface: Color(0xFF000000), // Tam siyah arka plan
    onSurface: Color(0xFFFFEB3B), // Sarı yazılar
    onSurfaceVariant: Color(0xFFFFC107),
    outline: Color(0xFFFFD54F),

    shadow: Colors.black,
    scrim: Colors.black87,
    inverseSurface: Color(0xFFFFEB3B), // Sarı
    inversePrimary: Colors.white, // Beyaz
  );
}
