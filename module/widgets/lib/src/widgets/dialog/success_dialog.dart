import 'package:flutter/material.dart';
import 'package:widgets/src/core/dialog_base.dart';

/// Show a dialog for succes
final class SuccessDialog extends StatelessWidget {
  /// Constructur for dialog
  const SuccessDialog({super.key, required this.title});

  /// Ttile for dialog
  final String title;

  /// Show the dialog for succes
  /// This will always retur [true]
  static Future<bool> show({
    required String title,
    required BuildContext context,
  }) async {
    await DialogBase.show<bool>(
      context: context,
      builder: (context) => SuccessDialog(title: title),
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text(title),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          icon: const Icon(Icons.check),
        ),
      ],
    );
  }
}
