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
    final selectedLocale =
        context.locale.languageCode == Locales.en.locale.languageCode
            ? Locales.en
            : Locales.tr;
    final heroGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        colorScheme.primary.withValues(alpha: 0.92),
        colorScheme.secondary.withValues(alpha: 0.82),
      ],
    );

    return Container(
      padding: EdgeInsets.all(context.sized.height * 0.03),
      decoration: BoxDecoration(
        gradient: heroGradient,
        borderRadius: BorderRadius.circular(normal * 1.8),
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
                width: context.sized.height * 0.075,
                height: context.sized.height * 0.075,
                padding: EdgeInsets.all(low * 0.65),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(normal * 1.2),
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
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: low * 0.4),
                    Text(
                      isLoggedIn
                          ? LocaleKeys.drawer_header_description_logged_in.tr(
                              namedArgs: {'user': _displayName(userName)},
                            )
                          : LocaleKeys.drawer_header_description_logged_out
                              .tr(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.84),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: normal * 1.1),
          Wrap(
            spacing: low * 0.7,
            runSpacing: low * 0.7,
            children: [
              _HeaderBadge(
                icon: isLoggedIn
                    ? Icons.verified_user_rounded
                    : Icons.explore_rounded,
                label: isLoggedIn
                    ? LocaleKeys.drawer_badge_member_mode.tr()
                    : LocaleKeys.drawer_badge_guest_mode.tr(),
              ),
              _HeaderBadge(
                icon: Icons.grid_view_rounded,
                label: LocaleKeys.drawer_badge_quick_category.tr(),
              ),
            ],
          ),
          SizedBox(height: normal * 1.1),
          Container(
            padding: EdgeInsets.all(normal),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(normal * 1.35),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.14),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.drawer_theme_title.tr(),
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: low * 0.55),
                Text(
                  LocaleKeys.drawer_theme_description.tr(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.78),
                    height: 1.35,
                  ),
                ),
                SizedBox(height: normal),
                SegmentedButton<ThemeMode>(
                  segments: [
                    ButtonSegment(
                      value: ThemeMode.light,
                      icon: const Icon(Icons.light_mode_rounded),
                      label: Text(LocaleKeys.general_theme_light.tr()),
                    ),
                    ButtonSegment(
                      value: ThemeMode.dark,
                      icon: const Icon(Icons.dark_mode_rounded),
                      label: Text(LocaleKeys.general_theme_dark.tr()),
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
                  style: ButtonStyle(
                    visualDensity: VisualDensity.compact,
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
                        borderRadius: BorderRadius.circular(normal),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: normal),
                Text(
                  LocaleKeys.general_language_title.tr(),
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: low * 0.55),
                Text(
                  LocaleKeys.general_language_description.tr(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.78),
                    height: 1.35,
                  ),
                ),
                SizedBox(height: normal),
                SegmentedButton<Locales>(
                  segments: [
                    ButtonSegment(
                      value: Locales.tr,
                      icon: const Icon(Icons.translate_rounded),
                      label: Text(LocaleKeys.terms_language_tr.tr()),
                    ),
                    ButtonSegment(
                      value: Locales.en,
                      icon: const Icon(Icons.language_rounded),
                      label: Text(LocaleKeys.terms_language_en.tr()),
                    ),
                  ],
                  selected: {selectedLocale},
                  onSelectionChanged: (values) async {
                    await ProductLocalization.updateLanguage(
                      context: context,
                      value: values.first,
                    );
                  },
                  style: ButtonStyle(
                    visualDensity: VisualDensity.compact,
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
                        borderRadius: BorderRadius.circular(normal),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: normal),
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
                  color: Colors.white.withValues(alpha: 0.28),
                ),
                minimumSize: Size.fromHeight(context.sized.height * 0.06),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(normal * 1.2),
                ),
              ),
            ),
          ),
        ],
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

class _HeaderBadge extends StatelessWidget {
  const _HeaderBadge({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final low = context.sized.lowValue;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.sized.normalValue * 0.8,
        vertical: low * 0.8,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(context.sized.normalValue * 1.5),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.16),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: context.sized.normalValue,
            color: Colors.white,
          ),
          SizedBox(width: low * 0.55),
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.92),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
