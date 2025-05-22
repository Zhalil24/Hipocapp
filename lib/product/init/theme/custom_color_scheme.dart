import 'package:flutter/material.dart';

/// Project Custom Color
final class CustomColorScheme {
  CustomColorScheme._();

  /// Light Color Scheme
  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light, // Tema türü: Açık tema

    primary: Color(0xFF2b4560), // Ana renk — Butonlar, AppBar, Seçili bileşenler
    onPrimary: Colors.white, // Primary üzerinde yazı/icon — Kontrast için beyaz
    primaryContainer: Color(0xFFFFE082), // Primary arka planı (kartlar, kutular)
    onPrimaryContainer: Colors.black, // PrimaryContainer üzerindeki yazılar

    secondary: Color(0xFFFFA000), // İkincil vurgu (FAB, toggle, ikonlar)
    onSecondary: Colors.white, // Secondary üstü (ikon/yazı) rengi
    secondaryContainer: Color(0xFFFFB74D), // Secondary arka planı (kart, etiket)
    onSecondaryContainer: Colors.black, // SecondaryContainer üstündeki yazılar

    tertiary: Color(0xFFFFD700), // Üçüncül renk (bazı uyarılar, sekmeler)
    onTertiary: Colors.black, // Tertiary üstündeki yazı/icon
    tertiaryContainer: Color(0xFFFFE57F), // Üçüncül arka planlar
    onTertiaryContainer: Colors.black, // TertiaryContainer üstü yazı/icon

    error: Color(0xFFD32F2F), // Hata durumu — Formlar, uyarılar
    onError: Colors.white, // Hata rengi üstünde yazı/icon
    errorContainer: Color(0xFFF44336), // Hatalı alanlar için arka plan
    onErrorContainer: Colors.black, // ErrorContainer içindeki metinler

    surface: Color(0xFFFDF6EC), // Sayfa arka planı / kartlar
    onSurface: Colors.black, // Yüzey (surface) üzerindeki yazılar
    onSurfaceVariant: Color(0xFF757575), // Alternatif yazı rengi (ikincil yazılar)

    outline: Color(0xFFBDBDBD), // Çizgiler / kenarlar / sınır çizgileri

    shadow: Colors.black45, // Gölge efekti (kart, buton vs.)
    scrim: Colors.black54, // Arka plan maskesi (dialog vs.)

    inverseSurface: Color(0xFF303030), // Dark mod arka plan (örn. snackbar)
    onInverseSurface: Colors.white, // InverseSurface üstündeki yazılar
    inversePrimary: Colors.black, // Primary rengin dark mode karşılığı

    // NOT: `surfaceTint` Material 3'te kart gölge efektiyle kullanılır
    surfaceTint: Color(0xFFFFD54F), // Hafif sarı – yüzeylere sıcaklık katmak için
  );

  /// Dark Color Scheme
  /// 🌙 Dark Color Scheme — Uygulama genelinde karanlık tema için renk ayarları
  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark, // Tema türü: Karanlık tema

    primary: Color(0xFF2b4560), // Altın sarısı — AppBar, butonlar, seçili öğeler
    onPrimary: Colors.black, // Primary üzerine yazılar/iconlar

    primaryContainer: Color(0xFFFFD54F), // Daha yumuşak sarı — container arka planı
    onPrimaryContainer: Colors.black, // PrimaryContainer üstü yazı/icon

    secondary: Color(0xFFFFC107), // Sarı — FAB, toggle, aktif simgeler
    onSecondary: Colors.black, // Secondary üstü yazılar

    secondaryContainer: Color(0xFF665252), // Secondary için arka plan
    onSecondaryContainer: Colors.black, // SecondaryContainer içi metinler

    tertiary: Color.fromARGB(255, 28, 28, 31),
    // Lacivert — alternatif vurgu rengi (ikon uyumu için)
    onTertiary: Colors.white, // Lacivert üzeri yazı/icon
    tertiaryContainer: Color(0xFF5A74AC), // Hafif açık lacivert
    onTertiaryContainer: Colors.white, // Container içi metin

    error: Color(0xFFB71C1C), // Koyu kırmızı — hata durumu
    onError: Colors.white, // Hata yazısı
    errorContainer: Color(0xFFD32F2F), // Hatalı alan arka planı
    onErrorContainer: Colors.black,

    surface: Color(0xFF121212), // Koyu gri/siyah — zemin, kartlar, scaffold
    onSurface: Colors.white, // Sarımsı yazılar (ikonla uyum)
    onSurfaceVariant: Colors.white, // İkincil yazı rengi

    outline: Color(0xFF9E9E9E), // Kenarlıklar, divider çizgileri

    shadow: Colors.black, // Gölge efekti
    scrim: Colors.black87, // Dialog arkası / maske

    inverseSurface: Color(0xFFFFEB3B), // Light mod yüzey (örn. snackbar)
    onInverseSurface: Colors.black, // Inverse üzeri yazı

    inversePrimary: Colors.white, // Primary’nin zıt modu (light için)
    surfaceTint: Color(0xFFFFA000), // Sarı-turuncu gölge efekti (Material 3)
  );
}
