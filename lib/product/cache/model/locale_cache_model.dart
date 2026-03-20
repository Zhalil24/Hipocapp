import 'package:core/core.dart';
import 'package:hipocapp/product/utility/enums/locales.dart';

final class LocaleCacheModel with CacheModel {
  const LocaleCacheModel({
    required this.localeIndex,
  });

  const LocaleCacheModel.empty() : localeIndex = 0;

  final int localeIndex;

  @override
  String get id => 'locale_cache';

  @override
  LocaleCacheModel fromDynamicJson(dynamic json) {
    final jsonMap = json as Map<String, dynamic>?;
    if (jsonMap == null || !jsonMap.containsKey('localeIndex')) {
      return const LocaleCacheModel.empty();
    }

    final idx = jsonMap['localeIndex'] as int;
    return LocaleCacheModel(localeIndex: idx);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'localeIndex': localeIndex,
    };
  }

  Locales get locale =>
      localeIndex == Locales.en.index ? Locales.en : Locales.tr;
}
