import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:hipocapp/product/utility/validator/validator.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class EntryListComposerWidget extends StatelessWidget {
  const EntryListComposerWidget({
    required this.formKey,
    required this.controller,
    required this.focusNode,
    required this.onSubmit,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Future<void> Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final low = context.sized.lowValue;
    final normal = context.sized.normalValue;

    return AppSurfaceCard(
      padding: EdgeInsets.all(context.sized.height * 0.024),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.entry_list_composer_title.tr(),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: low * 0.75),
            Text(
              LocaleKeys.entry_list_composer_description.tr(),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.70),
              ),
            ),
            SizedBox(height: normal),
            TextFormField(
              controller: controller,
              focusNode: focusNode,
              validator: Validators.notEmpty,
              minLines: 4,
              maxLines: 8,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                hintText: LocaleKeys.entry_list_composer_hint.tr(),
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest.withValues(
                  alpha: isDark ? 0.30 : 0.58,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(normal),
                  borderSide: BorderSide(
                    color: colorScheme.outline.withValues(alpha: 0.18),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(normal),
                  borderSide: BorderSide(
                    color: colorScheme.outline.withValues(alpha: 0.18),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(normal),
                  borderSide: BorderSide(
                    color: colorScheme.primary,
                  ),
                ),
              ),
            ),
            SizedBox(height: normal),
            Row(
              children: [
                Expanded(
                  child: Text(
                    LocaleKeys.entry_list_composer_tip.tr(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.64),
                      height: 1.45,
                    ),
                  ),
                ),
                SizedBox(width: low),
                FilledButton.icon(
                  onPressed: onSubmit,
                  icon: const Icon(Icons.send_rounded),
                  label: Text(LocaleKeys.general_button_share.tr()),
                  style: FilledButton.styleFrom(
                    minimumSize: Size(
                      context.sized.width * 0.24,
                      context.sized.height * 0.056,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(normal),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
