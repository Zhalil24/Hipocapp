import 'package:easy_localization/easy_localization.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';

class Validators {
  static String? notEmpty(String? value) {
    return (value == null || value.trim().isEmpty)
        ? LocaleKeys.validation_required.tr()
        : null;
  }

  static String? match(String? value, String? other, String fieldName) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validation_field_empty.tr(
        namedArgs: {'field': fieldName},
      );
    }
    if (value != other) {
      return LocaleKeys.validation_field_not_match.tr(
        namedArgs: {'field': fieldName},
      );
    }
    return null;
  }

  static String? email(String? value) {
    final pattern = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return (value != null && pattern.hasMatch(value.trim()))
        ? null
        : LocaleKeys.validation_email.tr();
  }
}
