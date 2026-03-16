import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AppSegmentedTabBar<T> extends StatelessWidget {
  const AppSegmentedTabBar({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.labelBuilder,
    required this.onChanged,
    this.iconBuilder,
  });

  final List<T> items;
  final T selectedItem;
  final String Function(T item) labelBuilder;
  final void Function(T item) onChanged;
  final IconData Function(T item)? iconBuilder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: low * 0.25),
      child: Row(
        children: items.map((item) {
          final isSelected = item == selectedItem;
          return Padding(
            padding: EdgeInsets.only(right: low * 0.75),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(normal * 1.5),
                onTap: () => onChanged(item),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  padding: EdgeInsets.symmetric(
                    horizontal: normal,
                    vertical: low * 0.95,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? colorScheme.primary
                        : colorScheme.surface.withValues(alpha: 0.82),
                    borderRadius: BorderRadius.circular(normal * 1.5),
                    border: Border.all(
                      color: isSelected
                          ? colorScheme.primary
                          : colorScheme.outline.withValues(alpha: 0.22),
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: colorScheme.primary.withValues(alpha: 0.22),
                              blurRadius: context.sized.height * 0.02,
                              offset: Offset(0, low * 0.4),
                            ),
                          ]
                        : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (iconBuilder != null) ...[
                        Icon(
                          iconBuilder!(item),
                          size: normal * 1.05,
                          color: isSelected
                              ? colorScheme.onPrimary
                              : colorScheme.onSurfaceVariant,
                        ),
                        SizedBox(width: low * 0.6),
                      ],
                      Text(
                        labelBuilder(item),
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: isSelected
                              ? colorScheme.onPrimary
                              : colorScheme.onSurface,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
