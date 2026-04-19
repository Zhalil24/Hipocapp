import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:hipocapp/product/init/product_localization.dart';
import 'package:hipocapp/product/utility/enums/locales.dart';
import 'package:hipocapp/product/widget/terms_popup/terms_popup_widget.dart';
import 'package:kartal/kartal.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({
    super.key,
    required this.isLoggedIn,
    required this.userName,
    required this.themeMode,
    required this.onThemeChanged,
  });

  final bool isLoggedIn;
  final String? userName;
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;
    final segmentTextStyle = theme.textTheme.labelSmall?.copyWith(
          color: Colors.white,
          fontSize: (theme.textTheme.labelSmall?.fontSize ?? normal * 0.5) - 1,
          fontWeight: FontWeight.w600,
        ) ??
        TextStyle(
          color: Colors.white,
          fontSize: normal * 0.42,
          fontWeight: FontWeight.w600,
        );
    final selectedLocale =
        context.locale.languageCode == Locales.en.locale.languageCode
            ? Locales.en
            : Locales.tr;

    return Container(
      padding: EdgeInsets.all(normal * 0.95),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary.withValues(alpha: 0.92),
            colorScheme.secondary.withValues(alpha: 0.82),
          ],
        ),
        borderRadius: BorderRadius.circular(normal * 1.55),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.18),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.14),
            blurRadius: context.sized.height * 0.032,
            offset: Offset(0, normal),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: context.sized.height * 0.06,
                height: context.sized.height * 0.06,
                padding: EdgeInsets.all(low * 0.5),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(normal),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.18),
                  ),
                ),
                child: Assets.images.logo.image(package: 'gen'),
              ),
              SizedBox(width: normal),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.drawer_header_title.tr(),
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: low * 0.22),
                    Text(
                      isLoggedIn
                          ? LocaleKeys.drawer_header_description_logged_in.tr(
                              namedArgs: {'user': _displayName(userName)},
                            )
                          : LocaleKeys.drawer_header_description_logged_out
                              .tr(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.84),
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: normal * 0.72),
          Container(
            padding: EdgeInsets.all(normal * 0.72),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(normal * 1.2),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.14),
              ),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.light_mode_rounded,
                            size: normal * 0.95,
                            color: Colors.white,
                          ),
                          SizedBox(width: low * 0.5),
                          Expanded(
                            child: SegmentedButton<ThemeMode>(
                              segments: [
                                ButtonSegment(
                                  value: ThemeMode.light,
                                  label: Text(
                                    LocaleKeys.general_theme_light.tr(),
                                    style: segmentTextStyle,
                                  ),
                                ),
                                ButtonSegment(
                                  value: ThemeMode.dark,
                                  label: Text(
                                    LocaleKeys.general_theme_dark.tr(),
                                    style: segmentTextStyle,
                                  ),
                                ),
                              ],
                              selected: {
                                themeMode == ThemeMode.dark
                                    ? ThemeMode.dark
                                    : ThemeMode.light,
                              },
                              onSelectionChanged: (values) {
                                onThemeChanged(values.first);
                              },
                              showSelectedIcon: false,
                              style: _segmentStyle(normal),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: low * 0.75),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.language_rounded,
                            size: normal * 0.95,
                            color: Colors.white,
                          ),
                          SizedBox(width: low * 0.5),
                          Expanded(
                            child: SegmentedButton<Locales>(
                              segments: [
                                ButtonSegment(
                                  value: Locales.tr,
                                  label: Text(
                                    LocaleKeys.terms_language_tr.tr(),
                                    style: segmentTextStyle,
                                  ),
                                ),
                                ButtonSegment(
                                  value: Locales.en,
                                  label: Text(
                                    LocaleKeys.terms_language_en.tr(),
                                    style: segmentTextStyle,
                                  ),
                                ),
                              ],
                              selected: {selectedLocale},
                              onSelectionChanged: (values) async {
                                await ProductLocalization.updateLanguage(
                                  context: context,
                                  value: values.first,
                                );
                              },
                              showSelectedIcon: false,
                              style: _segmentStyle(normal),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: normal * 0.55),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      await showDialog<void>(
                        context: context,
                        builder: (_) => const TermsPopup(),
                      );
                    },
                    icon: const Icon(Icons.description_outlined),
                    label: Text(LocaleKeys.drawer_terms_button.tr()),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: BorderSide(
                        color: Colors.white.withValues(alpha: 0.24),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: normal * 0.78,
                        vertical: low * 0.82,
                      ),
                      minimumSize:
                          Size.fromHeight(context.sized.height * 0.05),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(normal),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ButtonStyle _segmentStyle(double normal) {
    return ButtonStyle(
      visualDensity: const VisualDensity(horizontal: -2, vertical: -3),
      foregroundColor: WidgetStatePropertyAll(
        Colors.white.withValues(alpha: 0.92),
      ),
      side: WidgetStatePropertyAll(
        BorderSide(
          color: Colors.white.withValues(alpha: 0.24),
        ),
      ),
      backgroundColor: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white.withValues(alpha: 0.18);
          }
          return Colors.white.withValues(alpha: 0.05);
        },
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(normal * 0.88),
        ),
      ),
    );
  }

  String _displayName(String? value) {
    final trimmed = value?.trim() ?? '';
    return trimmed.isEmpty
        ? LocaleKeys.general_fallback_hipo_friend.tr()
        : trimmed;
  }
}
