import 'package:flutter/material.dart';
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

  String get _title {
    return _selectedLanguage == TermLanguageType.en ? 'Terms and Conditions' : 'Şartlar ve Koşullar';
  }

  String get _content {
    return _selectedLanguage == TermLanguageType.en ? TermsConstantsEn.termsAndConditions : TermsConstants.termsAndConditions;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        _title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Text(
            _content,
            style: const TextStyle(height: 1.5),
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      actions: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SegmentedButton<TermLanguageType>(
              segments: const [
                ButtonSegment(
                  value: TermLanguageType.en,
                  label: Text('EN'),
                ),
                ButtonSegment(
                  value: TermLanguageType.tr,
                  label: Text('TR'),
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
                _selectedLanguage == TermLanguageType.en ? 'View latest version on website' : 'Güncel versiyonu web sitesinde görüntüle',
              ),
            ),
            SizedBox(height: context.sized.lowValue),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                _selectedLanguage == TermLanguageType.en ? 'Close' : 'Kapat',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
