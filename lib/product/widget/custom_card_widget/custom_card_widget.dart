import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:hipocapp/product/navigation/app_router.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/utility/enums/chat_tab_type.dart';
import 'package:intl/intl.dart';
import 'package:kartal/kartal.dart';

class CustomCardWidget extends StatefulWidget {
  const CustomCardWidget({
    super.key,
    required this.title,
    required this.description,
    this.userName,
    this.date,
    this.userId,
    required this.isHomeCard,
  });

  final String title;
  final String description;
  final String? userName;
  final String? date;
  final int? userId;
  final bool isHomeCard;

  @override
  State<CustomCardWidget> createState() => _CustomCardWidgetState();
}

class _CustomCardWidgetState extends BaseState<CustomCardWidget>
    with TickerProviderStateMixin {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    String formatDate(String dateString) {
      if (dateString.trim().isEmpty) return dateString;
      final cleanedDateString = dateString.split('.').first;
      final inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
      final outputFormat = DateFormat('dd.MM.yyyy');
      final dateTime = inputFormat.parse(cleanedDateString);
      return outputFormat.format(dateTime);
    }

    return Column(
      children: [
        Card(
          color: colorScheme.onPrimary,
          margin: EdgeInsets.symmetric(
            horizontal: context.sized.lowValue * 0.2,
            vertical: context.sized.lowValue * 0.75,
          ),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.sized.lowValue * 1.1),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              context.sized.normalValue * 0.78,
              context.sized.lowValue * 0.9,
              context.sized.normalValue * 0.78,
              context.sized.lowValue * 0.75,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                        height: 1.2,
                      ),
                ),
                SizedBox(height: context.sized.lowValue * 0.85),
                Text(
                  widget.description,
                  maxLines: isExpanded ? null : 6,
                  overflow:
                      isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.48,
                      ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () {
                      setState(() => isExpanded = !isExpanded);
                    },
                    icon: Icon(
                      isExpanded ? Icons.expand_less : Icons.expand_more,
                      size: context.sized.normalValue,
                      color: colorScheme.primary,
                    ),
                    label: Text(
                      isExpanded
                          ? LocaleKeys.custom_card_hide.tr()
                          : LocaleKeys.custom_card_show_more.tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.primary,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.sized.lowValue * 0.5,
                        vertical: context.sized.lowValue * 0.2,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ),
                if (widget.userName != null || widget.date != null)
                  Padding(
                    padding: EdgeInsets.only(top: context.sized.lowValue * 0.2),
                    child: Wrap(
                      spacing: context.sized.normalValue,
                      runSpacing: context.sized.lowValue * 0.5,
                      children: [
                        if (widget.userName != null) ...[
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.person,
                                size: context.sized.normalValue,
                                color: Colors.grey,
                              ),
                              SizedBox(width: context.sized.lowValue),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(
                                    context.sized.lowValue,
                                  ),
                                  onTap:
                                      _canOpenProfile ? _openUserProfile : null,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: context.sized.lowValue * 0.2,
                                      vertical: context.sized.lowValue * 0.15,
                                    ),
                                    child: Text(
                                      widget.userName!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: _canOpenProfile
                                                ? colorScheme.primary
                                                : Colors.grey[600],
                                            fontWeight: _canOpenProfile
                                                ? FontWeight.w700
                                                : FontWeight.w500,
                                            decoration: _canOpenProfile
                                                ? TextDecoration.underline
                                                : TextDecoration.none,
                                            decorationColor: colorScheme.primary,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                        if (widget.date != null) ...[
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: context.sized.normalValue,
                                color: Colors.grey,
                              ),
                              SizedBox(width: context.sized.lowValue),
                              Text(
                                formatDate(widget.date!),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                if (widget.isHomeCard && productViewModel.state.isLogin)
                  Padding(
                    padding:
                        EdgeInsets.only(top: context.sized.normalValue * 0.85),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: FilledButton.icon(
                        onPressed: () async {
                          await context.router.push(
                            ChatUserListRoute(
                              tab: ChatTabType.users,
                              query: widget.userName,
                            ),
                          );
                        },
                        icon: const Icon(Icons.chat),
                        label: Text(
                          LocaleKeys.custom_card_send_message.tr(),
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              context.sized.mediumValue,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: context.sized.normalValue * 0.9,
                            vertical: context.sized.lowValue * 0.9,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Divider(
          height: context.sized.lowValue * 1.8,
          indent: context.sized.lowValue * 0.2,
          endIndent: context.sized.lowValue * 0.2,
          color: Colors.grey,
        ),
      ],
    );
  }

  bool get _canOpenProfile {
    final targetUserId = widget.userId;
    final targetUserName = widget.userName?.trim() ?? '';
    return productViewModel.state.isLogin &&
        targetUserId != null &&
        targetUserId > 0 &&
        targetUserName.isNotEmpty;
  }

  Future<void> _openUserProfile() async {
    if (!productViewModel.state.isLogin) {
      return;
    }

    final targetUserId = widget.userId;
    if (targetUserId == null || targetUserId <= 0) {
      return;
    }

    final currentUserId = productViewModel.state.currentUserId;
    if (currentUserId != null && currentUserId == targetUserId) {
      await context.router.push(ProfilRoute());
      return;
    }

    await context.router.push(
      ProfilRoute(
        userId: targetUserId,
        username: widget.userName,
      ),
    );
  }
}
