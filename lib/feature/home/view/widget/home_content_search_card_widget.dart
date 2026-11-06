import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class HomeContentSearchCardWidget extends StatelessWidget {
  const HomeContentSearchCardWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;

    return AppSurfaceCard(
      padding: EdgeInsets.symmetric(
        horizontal: normal,
        vertical: low * 0.8,
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: const Icon(Icons.search_rounded),
          suffixIcon: controller.text.trim().isNotEmpty
              ? IconButton(
                  onPressed: () {
                    controller.clear();
                    onChanged('');
                  },
                  icon: const Icon(Icons.close_rounded),
                )
              : null,
          filled: true,
          fillColor: colorScheme.surface.withValues(alpha: 0.82),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(normal * 1.05),
            borderSide: BorderSide(
              color: colorScheme.outline.withValues(alpha: 0.16),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(normal * 1.05),
            borderSide: BorderSide(
              color: colorScheme.outline.withValues(alpha: 0.16),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(normal * 1.05),
            borderSide: BorderSide(
              color: colorScheme.primary.withValues(alpha: 0.48),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: normal,
            vertical: low,
          ),
        ),
      ),
    );
  }
}
