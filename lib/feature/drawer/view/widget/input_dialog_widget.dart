import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:hipocapp/product/utility/validator/validator.dart';
import 'package:kartal/kartal.dart';

class InputDialogWidget extends StatefulWidget {
  const InputDialogWidget({
    super.key,
    required this.onSubmit,
    required this.titleController,
    required this.descController,
    this.headerLabel,
  });

  final Future<void> Function(String titleText, String descText) onSubmit;
  final TextEditingController titleController;
  final TextEditingController descController;
  final String? headerLabel;

  @override
  State<InputDialogWidget> createState() => _InputDialogWidgetState();
}

class _InputDialogWidgetState extends State<InputDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;

    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: normal,
        vertical: normal * 1.4,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(normal * 1.6),
      ),
      titlePadding: EdgeInsets.fromLTRB(
        normal * 1.2,
        normal * 1.1,
        normal * 1.2,
        low * 0.35,
      ),
      contentPadding: EdgeInsets.fromLTRB(
        normal * 1.2,
        low * 0.4,
        normal * 1.2,
        low,
      ),
      actionsPadding: EdgeInsets.fromLTRB(
        normal * 1.2,
        0,
        normal * 1.2,
        normal * 1.1,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.drawer_input_dialog_title.tr(),
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: low * 0.45),
          Text(
            LocaleKeys.drawer_input_dialog_description.tr(),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          if (widget.headerLabel?.trim().isNotEmpty ?? false) ...[
            SizedBox(height: normal * 0.8),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: normal * 0.8,
                vertical: low * 0.75,
              ),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(normal * 1.4),
              ),
              child: Text(
                widget.headerLabel!.trim(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ],
      ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: widget.titleController,
                validator: Validators.notEmpty,
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: LocaleKeys.general_form_title.tr(),
                  hintText: LocaleKeys.drawer_input_dialog_title_hint.tr(),
                  prefixIcon: const Icon(Icons.title_rounded),
                ),
              ),
              SizedBox(height: normal),
              TextFormField(
                controller: widget.descController,
                validator: Validators.notEmpty,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                minLines: 6,
                maxLines: 10,
                decoration: InputDecoration(
                  labelText: LocaleKeys.general_form_first_entry.tr(),
                  hintText: LocaleKeys.drawer_input_dialog_entry_hint.tr(),
                  alignLabelWithHint: true,
                  prefixIcon: const Icon(Icons.notes_rounded),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSubmitting
              ? null
              : () {
                  widget.titleController.clear();
                  widget.descController.clear();
                  Navigator.of(context).pop();
                },
          child: Text(LocaleKeys.general_button_cancel.tr()),
        ),
        FilledButton.icon(
          onPressed: _isSubmitting ? null : _submit,
          icon: _isSubmitting
              ? SizedBox(
                  width: context.sized.lowValue * 1.6,
                  height: context.sized.lowValue * 1.6,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      colorScheme.onPrimary,
                    ),
                  ),
                )
              : const Icon(Icons.send_rounded),
          label: Text(
            _isSubmitting
                ? LocaleKeys.general_button_sending.tr()
                : LocaleKeys.general_button_send.tr(),
          ),
          style: FilledButton.styleFrom(
            minimumSize: Size.fromHeight(context.sized.height * 0.058),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(normal * 1.1),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      final title = widget.titleController.text.trim();
      final desc = widget.descController.text.trim();
      await widget.onSubmit(title, desc);
      widget.titleController.clear();
      widget.descController.clear();
      if (mounted) {
        Navigator.of(context).pop();
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }
}
