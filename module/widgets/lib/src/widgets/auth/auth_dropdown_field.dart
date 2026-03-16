import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AuthDropdownField<T> extends StatelessWidget {
  const AuthDropdownField({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
    this.value,
    this.validator,
    this.icon = Icons.keyboard_arrow_down_rounded,
  });

  final String label;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String? Function(T?)? validator;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final normal = context.sized.normalValue;

    OutlineInputBorder border(Color color) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(normal * 1.25),
        borderSide: BorderSide(color: color),
      );
    }

    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: colorScheme.primary),
        filled: true,
        fillColor: isDark ? Colors.white.withValues(alpha: 0.04) : colorScheme.primary.withValues(alpha: 0.03),
        contentPadding: EdgeInsets.symmetric(
          horizontal: normal * 1.125,
          vertical: normal * 1.125,
        ),
        border: border(colorScheme.outline.withValues(alpha: 0.22)),
        enabledBorder: border(colorScheme.outline.withValues(alpha: 0.20)),
        focusedBorder: border(colorScheme.primary.withValues(alpha: 0.70)),
        errorBorder: border(colorScheme.error.withValues(alpha: 0.60)),
        focusedErrorBorder: border(colorScheme.error),
      ),
      borderRadius: BorderRadius.circular(normal * 1.25),
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: colorScheme.onSurfaceVariant,
      ),
      dropdownColor: colorScheme.surface,
      isExpanded: true,
    );
  }
}
