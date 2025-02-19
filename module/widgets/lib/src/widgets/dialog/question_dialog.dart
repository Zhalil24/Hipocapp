import 'package:flutter/material.dart';
import 'package:widgets/src/core/dialog_base.dart';

/// User question answer
final class QuestionAnswer {
  /// Constructur question  answer
  QuestionAnswer({required this.response});

  /// Answer text
  final String response;
}

/// Show a dialog for succes
final class QuestionDialog extends StatefulWidget {
  /// Constructur for dialog
  const QuestionDialog({super.key, required this.title});

  /// Ttile for dialog
  final String title;

  /// Show the dialog for succes
  /// This will always retur [true]
  static Future<QuestionAnswer?> show({
    required String title,
    required BuildContext context,
  }) async {
    return DialogBase.show<QuestionAnswer>(
      context: context,
      builder: (context) => QuestionDialog(title: title),
    );
  }

  @override
  State<QuestionDialog> createState() => _QuestionDialogState();
}

class _QuestionDialogState extends State<QuestionDialog> {
  String _resp = '';
  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text(widget.title),
      content: TextField(
        onChanged: (value) => _resp = value,
      ),
      actions: [
        IconButton(
          onPressed: () {
            if (_resp.isEmpty) Navigator.of(context).pop(null);
            Navigator.of(context).pop(QuestionAnswer(response: _resp));
          },
          icon: const Icon(Icons.check),
        ),
      ],
    );
  }
}
