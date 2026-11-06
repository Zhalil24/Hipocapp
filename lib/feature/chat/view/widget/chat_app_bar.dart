import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:kartal/kartal.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({
    super.key,
    this.userName,
    this.groupName,
    this.isOnline,
    this.showOnlineStatus = true,
    this.onProfileTap,
  });

  final String? userName;
  final String? groupName;
  final bool? isOnline;
  final bool showOnlineStatus;
  final VoidCallback? onProfileTap;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final title = (userName?.trim().isNotEmpty ?? false)
        ? userName!.trim()
        : (groupName?.trim().isNotEmpty ?? false)
            ? groupName!.trim()
            : LocaleKeys.chat_fallback_title.tr();

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: AppBar(
          backgroundColor: colorScheme.surface.withValues(alpha: 0.72),
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
          systemOverlayStyle:
              isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
          leading: IconButton(
            onPressed: () => context.router.maybePop(),
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          titleSpacing: 0,
          title: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius:
                  BorderRadius.circular(context.sized.normalValue * 1.1),
              onTap: onProfileTap,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: context.sized.lowValue * 0.15,
                ),
                child: Row(
                  children: [
                    Container(
                      width: context.sized.height * 0.048,
                      height: context.sized.height * 0.048,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            colorScheme.primary.withValues(alpha: 0.88),
                            colorScheme.secondary.withValues(alpha: 0.72),
                          ],
                        ),
                        borderRadius:
                            BorderRadius.circular(context.sized.normalValue),
                      ),
                      child: Icon(
                        showOnlineStatus
                            ? Icons.chat_bubble_rounded
                            : Icons.groups_rounded,
                        color: colorScheme.onPrimary,
                        size: context.sized.normalValue,
                      ),
                    ),
                    SizedBox(width: context.sized.lowValue * 0.9),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  title,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: onProfileTap != null
                                        ? colorScheme.primary
                                        : null,
                                  ),
                                ),
                              ),
                              if (onProfileTap != null) ...[
                                SizedBox(width: context.sized.lowValue * 0.35),
                                Icon(
                                  Icons.open_in_new_rounded,
                                  size: context.sized.lowValue * 1.55,
                                  color: colorScheme.primary,
                                ),
                              ],
                            ],
                          ),
                          SizedBox(height: context.sized.lowValue * 0.15),
                          Text(
                            showOnlineStatus
                                ? (isOnline ?? false)
                                    ? LocaleKeys.general_status_online.tr()
                                    : LocaleKeys.general_status_direct_chat.tr()
                                : LocaleKeys.general_status_group_chat.tr(),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
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
        ),
      ),
    );
  }
}
