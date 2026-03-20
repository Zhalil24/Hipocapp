import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:hipocapp/product/widget/circle_avatar/custom_circle_avatar.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class UserListWidget extends StatelessWidget {
  const UserListWidget({
    super.key,
    this.photoURL,
    this.username,
    this.unreadMessageCount,
    required this.isOnline,
    required this.onTap,
  });

  final String? photoURL;
  final String? username;
  final VoidCallback onTap;
  final int? unreadMessageCount;
  final bool? isOnline;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;
    final unreadCount = unreadMessageCount ?? 0;

    return AppSurfaceCard(
      padding: EdgeInsets.symmetric(
        horizontal: normal,
        vertical: low * 0.95,
      ),
      margin: EdgeInsets.only(bottom: low * 0.85),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(normal * 1.35),
          onTap: onTap,
          child: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: EdgeInsets.all(low * 0.35),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          colorScheme.primary.withValues(alpha: 0.18),
                          colorScheme.secondary.withValues(alpha: 0.10),
                        ],
                      ),
                    ),
                    child: CustomCircleAvatar(
                      imageURL: photoURL ?? '',
                      radius: context.sized.height * 0.034,
                      icon: Icons.person_outline_rounded,
                      backgroundColor:
                          colorScheme.primary.withValues(alpha: 0.12),
                    ),
                  ),
                  Positioned(
                    right: low * 0.2,
                    bottom: low * 0.2,
                    child: Container(
                      width: context.sized.lowValue * 1.7,
                      height: context.sized.lowValue * 1.7,
                      decoration: BoxDecoration(
                        color: (isOnline ?? false)
                            ? Colors.green
                            : colorScheme.outline,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.surface,
                          width: low * 0.25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: normal),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username ?? LocaleKeys.general_fallback_unknown_user.tr(),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: low * 0.32),
                    Text(
                      unreadCount > 0
                          ? LocaleKeys.chat_user_list_user_unread_count.tr(
                              namedArgs: {'count': '$unreadCount'},
                            )
                          : (isOnline ?? false)
                              ? LocaleKeys.chat_user_list_user_active.tr()
                              : LocaleKeys.chat_user_list_user_tap_to_start
                                  .tr(),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: low * 0.75),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (unreadCount > 0)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: low * 0.8,
                        vertical: low * 0.6,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(normal),
                      ),
                      child: Text(
                        '$unreadCount',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  SizedBox(height: low * 0.45),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
