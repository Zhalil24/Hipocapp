import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AuthUploadCard extends StatelessWidget {
  const AuthUploadCard({
    super.key,
    required this.title,
    required this.description,
    required this.buttonLabel,
    required this.onPressed,
    this.preview,
    this.errorText,
    this.emptyIcon = Icons.badge_outlined,
  });

  final String title;
  final String description;
  final String buttonLabel;
  final VoidCallback onPressed;
  final Widget? preview;
  final String? errorText;
  final IconData emptyIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final low = context.sized.lowValue;
    final normal = context.sized.normalValue;
    final previewHeight = context.sized.height * 0.18;
    final hasError = errorText != null && errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(normal),
          decoration: BoxDecoration(
            color: colorScheme.surface.withValues(alpha: 0.76),
            borderRadius: BorderRadius.circular(normal * 1.375),
            border: Border.all(
              color: hasError ? colorScheme.error : colorScheme.outline.withValues(alpha: 0.24),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: low * 0.5),
              Text(
                description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
              SizedBox(height: normal),
              Container(
                width: double.infinity,
                height: previewHeight,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(normal * 1.125),
                  border: Border.all(
                    color: colorScheme.outline.withValues(alpha: 0.18),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(normal * 1.125),
                  child: preview ??
                      Center(
                        child: Icon(
                          emptyIcon,
                          size: context.sized.height * 0.05,
                          color: colorScheme.primary,
                        ),
                      ),
                ),
              ),
              SizedBox(height: normal),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: onPressed,
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size.fromHeight(context.sized.height * 0.062),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(normal * 1.125),
                    ),
                  ),
                  icon: const Icon(Icons.upload_rounded),
                  label: Text(buttonLabel),
                ),
              ),
            ],
          ),
        ),
        if (hasError)
          Padding(
            padding: EdgeInsets.only(
              top: low * 0.5,
              left: normal,
            ),
            child: Text(
              errorText!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.error,
              ),
            ),
          ),
      ],
    );
  }
}
