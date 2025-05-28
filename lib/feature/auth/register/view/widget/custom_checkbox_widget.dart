import 'package:flutter/material.dart';

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField({
    Key? key,
    required Widget title,
    required bool initialValue,
    required FormFieldValidator<bool> validator,
    required ValueChanged<bool?> onChanged,
  }) : super(
          key: key,
          initialValue: initialValue,
          validator: validator,
          builder: (FormFieldState<bool> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CheckboxListTile(
                  title: title,
                  value: state.value,
                  onChanged: (value) {
                    state.didChange(value);
                    onChanged(value);
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      state.errorText ?? '',
                      style: TextStyle(
                        color: Theme.of(state.context).colorScheme.error,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            );
          },
        );
}
