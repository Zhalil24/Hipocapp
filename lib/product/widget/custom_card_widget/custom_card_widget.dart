import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/navigation/app_router.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/utility/enums/chat_tab_type.dart';
import 'package:intl/intl.dart';
import 'package:kartal/kartal.dart';

class CustomCardWidget extends StatefulWidget {
  final String title;
  final String description;
  final String? userName;
  final String? date;
  final int? userId;
  final bool isHomeCard;
  const CustomCardWidget({
    super.key,
    required this.title,
    required this.description,
    this.userName,
    this.date,
    this.userId,
    required this.isHomeCard,
  });

  @override
  State<CustomCardWidget> createState() => _CustomCardWidgetState();
}

class _CustomCardWidgetState extends BaseState<CustomCardWidget> with TickerProviderStateMixin {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    String formatDate(String dateString) {
      final cleanedDateString = dateString.replaceFirst('Tarih: ', '').split('.').first;
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
            horizontal: context.sized.lowValue,
            vertical: context.sized.lowValue,
          ),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.sized.lowValue),
          ),
          child: Padding(
            padding: EdgeInsets.all(context.sized.lowValue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                ),
                SizedBox(height: context.sized.lowValue),
                Text(
                  widget.description,
                  maxLines: isExpanded ? null : 4,
                  overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
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
                      isExpanded ? 'Gizle' : 'Devamını Göster',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                if (widget.userName != null || widget.date != null)
                  Padding(
                    padding: EdgeInsets.only(top: context.sized.lowValue),
                    child: Row(
                      children: [
                        if (widget.userName != null) ...[
                          Icon(Icons.person, size: context.sized.normalValue, color: Colors.grey),
                          SizedBox(width: context.sized.lowValue),
                          Text(
                            widget.userName!,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                          ),
                          SizedBox(width: context.sized.normalValue),
                        ],
                        if (widget.date != null) ...[
                          Icon(Icons.calendar_today, size: context.sized.normalValue, color: Colors.grey),
                          SizedBox(width: context.sized.lowValue),
                          Text(
                            formatDate(widget.date!),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                          ),
                        ],
                      ],
                    ),
                  ),
                if (widget.isHomeCard && productViewModel.state.isLogin)
                  Padding(
                    padding: EdgeInsets.only(top: context.sized.normalValue),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: FilledButton.icon(
                        onPressed: () async {
                          await context.router.push(ChatUserListRoute(
                            tab: ChatTabType.users,
                            query: widget.userName,
                          ));
                        },
                        icon: const Icon(Icons.chat),
                        label: const Text('Mesaj Gönder'),
                        style: FilledButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(context.sized.mediumValue),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: context.sized.normalValue,
                            vertical: context.sized.lowValue,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Divider(height: context.sized.normalValue, color: Colors.grey),
      ],
    );
  }
}
