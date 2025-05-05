import 'package:flutter/material.dart';
import 'package:hipocapp/product/widget/button/custom_action_button/custom_action_button.dart';

class InputDialogWidget extends StatefulWidget {
  final void Function(String titleText, String descText) onSubmit;
  final String message;
  final TextEditingController titleController;
  final TextEditingController descController;

  const InputDialogWidget({
    required this.onSubmit,
    required this.message,
    required this.titleController,
    required this.descController,
  });

  @override
  State<InputDialogWidget> createState() => _InputDialogWidgetState();
}

class _InputDialogWidgetState extends State<InputDialogWidget> {
  String titleText = '';
  String descText = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          TextField(
            controller: widget.titleController,
            decoration: const InputDecoration(labelText: 'Başlık'),
            onChanged: (value) {
              setState(() {
                titleText = value;
              });
            },
          ),
          const SizedBox(height: 8),
          TextField(
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
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('İptal'),
        ),
        CustomActionButton(
            controllers: [widget.titleController, widget.descController],
            onTop: () {
              if (titleText.trim().isNotEmpty || descText.trim().isNotEmpty) {
                widget.onSubmit(titleText.trim(), descText.trim());
              }
              Navigator.of(context).pop();
            },
            text: 'Gönder',
            message: widget.message)
      ],
    );
  }
}
