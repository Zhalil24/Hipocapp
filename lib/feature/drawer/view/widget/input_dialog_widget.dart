import 'package:flutter/material.dart';

class InputDialogWidget extends StatefulWidget {
  final void Function(String titleText, String descText) onSubmit;

  const InputDialogWidget({required this.onSubmit});

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
            decoration: const InputDecoration(labelText: 'Başlık'),
            onChanged: (value) {
              setState(() {
                titleText = value;
              });
            },
          ),
          const SizedBox(height: 8),
          TextField(
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
        ElevatedButton(
          onPressed: () {
            if (titleText.trim().isNotEmpty || descText.trim().isNotEmpty) {
              widget.onSubmit(titleText.trim(), descText.trim());
            }
            Navigator.of(context).pop();
          },
          child: const Text('Gönder'),
        ),
      ],
    );
  }
}
