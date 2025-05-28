import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class PhotoPickerField extends StatelessWidget {
  final File? selectedPhoto;
  final VoidCallback onPickImage;
  final String? Function(File?)? validator;

  const PhotoPickerField({
    required this.selectedPhoto,
    required this.onPickImage,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<File>(
      validator: validator,
      initialValue: selectedPhoto,
      builder: (formFieldState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: context.sized.highValue * 4,
              height: context.sized.highValue * 3,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border.all(
                  color: formFieldState.hasError ? Colors.red : Colors.grey.shade400,
                ),
                image: selectedPhoto != null
                    ? DecorationImage(
                        image: FileImage(selectedPhoto!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: selectedPhoto == null
                  ? Icon(
                      Icons.photo,
                      size: context.sized.highValue,
                      color: Colors.grey,
                    )
                  : null,
            ),
            SizedBox(height: context.sized.normalValue),
            TextButton(
              onPressed: () {
                onPickImage();
                formFieldState.didChange(selectedPhoto);
              },
              child: const Text('Kurum Kimliği Seçin'),
            ),
            if (formFieldState.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  formFieldState.errorText ?? '',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
