import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_architecture_template/product/utility/enums/locales.dart';

@immutable

/// Product locazitaion manager
final class ProductLocalization extends EasyLocalization {
  /// ProductLocalization need o [child] for a wrap local item
  ProductLocalization({super.key, required super.child})
      : super(
          supportedLocales: _suppertedItems,
          path: _translationPath,
          useOnlyLangCode: true,
        );

  static final List<Locale> _suppertedItems = [Locales.tr.locale, Locales.en.locale];
  static const String _translationPath = 'asset/translations';

  /// Change project langueage by using [Locale]
  static Future<void> updateLanguage({
    required BuildContext context,
    required Locales value,
  }) =>
      context.setLocale(value.locale);
}
