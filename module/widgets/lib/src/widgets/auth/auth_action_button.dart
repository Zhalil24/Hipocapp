import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AuthPrimaryButton extends StatelessWidget {
  const AuthPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.icon = Icons.arrow_forward_rounded,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final normal = context.sized.normalValue;

    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: isLoading ? null : onPressed,
        style: FilledButton.styleFrom(
          minimumSize: Size.fromHeight(context.sized.height * 0.07),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(normal * 1.25),
          ),
        ),
        icon: isLoading
            ? SizedBox(
                width: normal * 1.2,
                height: normal * 1.2,
                child: CircularProgressIndicator(
                  strokeWidth: 2.2,
                  color: colorScheme.onPrimary,
                ),
              )
            : Icon(icon),
        label: Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}

class AuthSecondaryButton extends StatelessWidget {
  const AuthSecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon = Icons.person_add_alt_1_rounded,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final normal = context.sized.normalValue;

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          minimumSize: Size.fromHeight(context.sized.height * 0.0675),
          side: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.34),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(normal * 1.125),
          ),
        ),
        icon: Icon(icon),
        label: Text(label),
      ),
    );
  }
}
