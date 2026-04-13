import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AppFollowUserListPopup extends StatelessWidget {
  const AppFollowUserListPopup({
    super.key,
    required this.title,
    required this.userNames,
    required this.emptyMessage,
  });

  final String title;
  final List<String> userNames;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;

    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: normal,
        vertical: normal * 1.2,
      ),
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 420,
          maxHeight: context.sized.height * 0.62,
        ),
        child: Container(
          padding: EdgeInsets.all(normal),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(normal * 1.4),
            border: Border.all(
              color: colorScheme.outline.withValues(alpha: 0.16),
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withValues(alpha: 0.12),
                blurRadius: context.sized.height * 0.022,
                offset: Offset(0, low * 0.8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              SizedBox(height: low * 0.55),
              Flexible(
                child: userNames.isEmpty
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: normal,
                            vertical: normal * 1.2,
                          ),
                          child: Text(
                            emptyMessage,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                              height: 1.4,
                            ),
                          ),
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        itemCount: userNames.length,
                        separatorBuilder: (_, __) =>
                            SizedBox(height: low * 0.55),
                        itemBuilder: (context, index) {
                          final userName = userNames[index];
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: normal * 0.82,
                              vertical: low * 0.78,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.primary.withValues(alpha: 0.06),
                              borderRadius:
                                  BorderRadius.circular(normal * 1.05),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: context.sized.height * 0.018,
                                  backgroundColor: colorScheme.primary
                                      .withValues(alpha: 0.14),
                                  child: Icon(
                                    Icons.person_outline_rounded,
                                    size: context.sized.normalValue * 0.82,
                                    color: colorScheme.primary,
                                  ),
                                ),
                                SizedBox(width: low * 0.7),
                                Expanded(
                                  child: Text(
                                    userName,
                                    style:
                                        theme.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
