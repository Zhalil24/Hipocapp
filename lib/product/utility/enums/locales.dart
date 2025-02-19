import 'package:flutter/material.dart';

///Project locale enum for operation and configration
enum Locales {
  /// Turkish Locale
  tr(Locale('tr', 'TR')),

  /// Engilish Locale
  en(Locale('en', 'US'));

  ///Local value
  final Locale locale;

  // ignore: sort_constructors_first
  const Locales(this.locale);
}
