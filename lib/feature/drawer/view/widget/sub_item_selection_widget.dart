import 'package:flutter/material.dart';
import 'package:hipocapp/feature/drawer/view/widget/input_dialog_widget.dart';
import 'package:kartal/kartal.dart';

class SubItemSelectionWidget extends StatelessWidget {
  final bool isSubItemSelected;
  final TextEditingController titleController;
  final TextEditingController descController;

  /// A function that handles the creation of a new entry.
  ///
  /// [title] - The title of the new entry.
  /// [desc] - The description of the new entry.
  final void Function(String, String) onCreateEntry;

  const SubItemSelectionWidget({
    Key? key,
    required this.isSubItemSelected,
    required this.onCreateEntry,
    required this.titleController,
    required this.descController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isSubItemSelected) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            showDialog<void>(
              context: context,
              builder: (context) => InputDialogWidget(
                titleController: titleController,
                descController: descController,
                onSubmit: onCreateEntry,
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.sized.highValue,
              vertical: context.sized.lowValue,
            ),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(context.sized.normalValue),
              border: Border.all(color: Colors.blue),
            ),
            child: const Text(
              'Başlık Aç',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
