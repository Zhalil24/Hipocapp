import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AuthCheckboxField extends FormField<bool> {
  AuthCheckboxField({
    super.key,
    required Widget title,
    required bool initialValue,
    required FormFieldValidator<bool> validator,
    required ValueChanged<bool> onChanged,
  }) : super(
          initialValue: initialValue,
          validator: validator,
          builder: (FormFieldState<bool> state) {
            final context = state.context;
            final theme = Theme.of(context);
            final colorScheme = theme.colorScheme;
            final normal = context.sized.normalValue;
            final low = context.sized.lowValue;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surface.withValues(alpha: 0.72),
                    borderRadius: BorderRadius.circular(normal * 1.25),
                    border: Border.all(
                      color: state.hasError ? colorScheme.error : colorScheme.outline.withValues(alpha: 0.24),
                    ),
                  ),
                  child: CheckboxListTile(
                    title: title,
                    value: state.value ?? false,
                    onChanged: (value) {
                      final nextValue = value ?? false;
                      state.didChange(nextValue);
                      onChanged(nextValue);
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: normal,
                      vertical: low * 0.25,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(normal * 1.25),
                    ),
                  ),
                ),
                if (state.hasError)
                  Padding(
                    padding: EdgeInsets.only(
                      top: low * 0.5,
                      left: normal,
                    ),
                    child: Text(
                      state.errorText ?? '',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.error,
                      ),
                    ),
                  ),
              ],
            );
          },
        );
}
