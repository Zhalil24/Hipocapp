import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class MenuStructureWidget extends StatelessWidget {
  const MenuStructureWidget({
    super.key,
    required this.menuStructure,
    required this.selectedHeaderText,
    required this.onItemSelected,
  });

  final Map<String, Map<String, String>> menuStructure;
  final String? selectedHeaderText;
  final Future<void> Function(String) onItemSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;

    return AppSurfaceCard(
      padding: EdgeInsets.all(context.sized.height * 0.026),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.drawer_menu_title.tr(),
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: low * 0.55),
          Text(
            LocaleKeys.drawer_menu_description.tr(),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.45,
            ),
          ),
          SizedBox(height: normal),
          ...menuStructure.entries.map(
            (mainEntry) {
              final mainTitle = mainEntry.key;
              final subItems = mainEntry.value;
              final isExpanded = subItems.values.any(
                (value) => _normalize(value) == _normalize(selectedHeaderText),
              );

              return Padding(
                padding: EdgeInsets.only(bottom: low * 0.8),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(normal * 1.3),
                    border: Border.all(
                      color: colorScheme.outline.withValues(alpha: 0.16),
                    ),
                  ),
                  child: Theme(
                    data: theme.copyWith(
                      dividerColor: Colors.transparent,
                    ),
                    child: ExpansionTile(
                      key: PageStorageKey(mainTitle),
                      initiallyExpanded: isExpanded,
                      leading: Container(
                        width: context.sized.height * 0.045,
                        height: context.sized.height * 0.045,
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(normal),
                        ),
                        child: Icon(
                          Icons.dashboard_customize_outlined,
                          color: colorScheme.primary,
                          size: context.sized.normalValue,
                        ),
                      ),
                      tilePadding: EdgeInsets.symmetric(
                        horizontal: normal,
                        vertical: low * 0.15,
                      ),
                      childrenPadding: EdgeInsets.fromLTRB(
                        low * 0.8,
                        0,
                        low * 0.8,
                        low * 0.8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(normal * 1.3),
                      ),
                      collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(normal * 1.3),
                      ),
                      title: Text(
                        mainTitle,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        LocaleKeys.general_count_sub_category.tr(
                          namedArgs: {'count': '${subItems.length}'},
                        ),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      children: subItems.entries.map(
                        (subEntry) {
                          final visibleText = subEntry.key;
                          final backendValue = subEntry.value;
                          final isSelected = _normalize(selectedHeaderText) ==
                              _normalize(backendValue);

                          return Padding(
                            padding: EdgeInsets.only(top: low * 0.45),
                            child: Material(
                              color: isSelected
                                  ? colorScheme.primary.withValues(alpha: 0.10)
                                  : colorScheme.surface.withValues(alpha: 0.78),
                              borderRadius: BorderRadius.circular(normal * 1.1),
                              child: InkWell(
                                borderRadius:
                                    BorderRadius.circular(normal * 1.1),
                                onTap: () async {
                                  await onItemSelected(backendValue);
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: normal,
                                    vertical: low * 0.95,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        isSelected
                                            ? Icons.check_circle_rounded
                                            : Icons.arrow_forward_ios_rounded,
                                        size: context.sized.lowValue * 1.7,
                                        color: isSelected
                                            ? colorScheme.primary
                                            : colorScheme.onSurfaceVariant,
                                      ),
                                      SizedBox(width: low * 0.8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              visibleText,
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(height: low * 0.2),
                                            Text(
                                              backendValue,
                                              style: theme.textTheme.bodySmall
                                                  ?.copyWith(
                                                color: colorScheme
                                                    .onSurfaceVariant,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String _normalize(String? value) {
    return (value ?? '').trim().toLowerCase();
  }
}
