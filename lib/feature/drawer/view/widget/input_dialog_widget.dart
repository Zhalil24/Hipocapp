import 'package:flutter/material.dart';
import 'package:hipocapp/product/utility/validator/validator.dart';
import 'package:hipocapp/product/widget/button/custom_action_button/custom_action_button.dart';

class InputDialogWidget extends StatefulWidget {
  final void Function(String titleText, String descText) onSubmit;
  final TextEditingController titleController;
  final TextEditingController descController;

  const InputDialogWidget({
    required this.onSubmit,
    required this.titleController,
    required this.descController,
  });

  @override
  State<InputDialogWidget> createState() => _InputDialogWidgetState();
}

class _InputDialogWidgetState extends State<InputDialogWidget> {
  String titleText = '';
  String descText = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            TextFormField(
              validator: Validators.notEmpty,
              controller: widget.titleController,
              decoration: const InputDecoration(labelText: 'Başlık'),
              onChanged: (value) {
                setState(() {
                  titleText = value;
                });
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              validator: Validators.notEmpty,
              controller: widget.descController,
              decoration: const InputDecoration(
                labelText: 'Entry',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
              minLines: 10,
              maxLines: null,
              onChanged: (value) {
                setState(() {
                  descText = value;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('İptal'),
        ),
        CustomActionButton(
          text: 'Gönder',
          onTop: () {
            if (_formKey.currentState?.validate() ?? false) {
              final title = widget.titleController.text.trim();
              final desc = widget.descController.text.trim();
              widget.onSubmit(title, desc);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
