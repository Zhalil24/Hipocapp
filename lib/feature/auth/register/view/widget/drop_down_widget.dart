import 'package:flutter/material.dart';

class DropdownFormField<T> extends StatelessWidget {
  final String hint;
  final T? value;
  final List<DropdownMenuItem<T>>? items;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;

  const DropdownFormField({
    required this.hint,
    this.value,
    this.items,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      validator: validator,
      builder: (formFieldState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<T>(
              hint: Text(hint),
              value: value,
              isExpanded: true,
              items: items,
              onChanged: (value) {
                onChanged?.call(value);
                formFieldState.didChange(value);
              },
            ),
            if (formFieldState.hasError)
              Text(
                formFieldState.errorText ?? '',
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
          ],
        );
      },
    );
  }
}
