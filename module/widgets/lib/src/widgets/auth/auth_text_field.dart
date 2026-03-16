import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.suffixIcon,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.obscureText = false,
    this.onFieldSubmitted,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final bool obscureText;
  final ValueChanged<String>? onFieldSubmitted;
  final int maxLines;

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

    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autofillHints: autofillHints,
      obscureText: obscureText,
      onFieldSubmitted: onFieldSubmitted,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: colorScheme.primary),
        suffixIcon: suffixIcon,
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
    );
  }
}
