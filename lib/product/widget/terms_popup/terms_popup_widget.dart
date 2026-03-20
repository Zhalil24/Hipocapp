import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:hipocapp/product/utility/constans/term/terms_constants.dart';
import 'package:hipocapp/product/utility/constans/term/terms_constants_en.dart';
import 'package:hipocapp/product/utility/enums/term_language_type.dart';
import 'package:kartal/kartal.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsPopup extends StatefulWidget {
  const TermsPopup({super.key});

  @override
  State<TermsPopup> createState() => _TermsPopupState();
}

class _TermsPopupState extends State<TermsPopup> {
  TermLanguageType _selectedLanguage = TermLanguageType.en;
  late final Future<void> _translationsFuture;
  Map<String, dynamic> _enTranslations = const {};
  Map<String, dynamic> _trTranslations = const {};

  @override
  void initState() {
    super.initState();
    _translationsFuture = _loadTranslations();
  }

  String get _content {
    return _selectedLanguage == TermLanguageType.en
        ? TermsConstantsEn.termsAndConditions
        : TermsConstants.termsAndConditions;
  }

  Future<void> _loadTranslations() async {
    _enTranslations = await const RootBundleAssetLoader().load(
          'asset/translations',
          const Locale('en'),
        ) ??
        const {};
    _trTranslations = await const RootBundleAssetLoader().load(
          'asset/translations',
          const Locale('tr'),
        ) ??
        const {};
  }

  String _translatedValue(String key) {
    final source = _selectedLanguage == TermLanguageType.en
        ? _enTranslations
        : _trTranslations;

    dynamic value = source;
    for (final part in key.split('.')) {
      if (value is Map<String, dynamic> && value.containsKey(part)) {
        value = value[part];
      } else {
        return key;
      }
    }

    return value is String ? value : key;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _translationsFuture,
      builder: (context, snapshot) {
        final isReady = snapshot.connectionState == ConnectionState.done;

        return AlertDialog(
          title: Text(
            isReady
                ? _translatedValue(LocaleKeys.terms_title)
                : LocaleKeys.terms_title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: isReady
                ? SingleChildScrollView(
                    child: Text(
                      _content,
                      style: const TextStyle(height: 1.5),
                    ),
                  )
                : const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: CircularProgressIndicator(),
                    ),
                  ),
          ),
          actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          actions: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SegmentedButton<TermLanguageType>(
                  segments: [
                    ButtonSegment(
                      value: TermLanguageType.en,
                      label: Text(LocaleKeys.terms_language_en.tr()),
                    ),
                    ButtonSegment(
                      value: TermLanguageType.tr,
                      label: Text(LocaleKeys.terms_language_tr.tr()),
                    ),
                  ],
                  selected: {_selectedLanguage},
                  onSelectionChanged: (value) {
                    setState(() => _selectedLanguage = value.first);
                  },
                ),
                SizedBox(height: context.sized.lowValue),
                OutlinedButton.icon(
                  onPressed: () async {
                    await launchUrl(
                      Uri.parse('https://hipocapp.com/kvkkandcsaeandcsam'),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  icon: const Icon(Icons.open_in_new, size: 18),
                  label: Text(
                    isReady
                        ? _translatedValue(LocaleKeys.terms_view_latest)
                        : LocaleKeys.terms_view_latest,
                  ),
                ),
                SizedBox(height: context.sized.lowValue),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    isReady
                        ? _translatedValue(LocaleKeys.terms_close)
                        : LocaleKeys.terms_close,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
