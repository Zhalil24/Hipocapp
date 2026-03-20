import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/cache/model/locale_cache_model.dart';
import 'package:hipocapp/product/state/container/product_satate_items.dart';
import 'package:hipocapp/product/utility/enums/locales.dart';

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

  static final List<Locale> _suppertedItems = [
    Locales.tr.locale,
    Locales.en.locale
  ];
  static const String _translationPath = 'asset/translations';

  /// Change project langueage by using [Locale]
  static Future<void> updateLanguage({
    required BuildContext context,
    required Locales value,
  }) async {
    await context.setLocale(value.locale);
    await ProductStateItems.productCache.localeCacheOperation.add(
      LocaleCacheModel(localeIndex: value.index),
    );
  }

  /// Load cached language and apply it to easy_localization.
  static Future<void> loadCachedLanguage({
    required BuildContext context,
  }) async {
    final id = const LocaleCacheModel.empty().id;
    final raw = await ProductStateItems.productCache.localeCacheOperation.get(
      id,
    );
    if (!context.mounted) return;
    final model = raw ?? const LocaleCacheModel.empty();

    if (context.locale.languageCode == model.locale.locale.languageCode) {
      return;
    }

    await context.setLocale(model.locale.locale);
  }
}
