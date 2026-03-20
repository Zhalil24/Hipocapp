import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/feature/chat/view/widget/group_message_container_widget.dart';
import 'package:hipocapp/feature/chat/view/widget/message_container_widget.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:hipocapp/product/utility/decrypt/chat_crypto_utils.dart';
import 'package:hipocapp/product/widget/custom_loader/custom_loader_widget.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class ChatMessageListWidget extends StatelessWidget {
  const ChatMessageListWidget({
    super.key,
    required this.isLoading,
    required this.isGroupConversation,
    required this.currentUserId,
    required this.messageList,
    required this.groupMessageList,
    required this.scrollController,
  });

  final bool isLoading;
  final bool isGroupConversation;
  final int? currentUserId;
  final List<MessageListModel> messageList;
  final List<GroupMessageModel> groupMessageList;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;
    final itemCount =
        isGroupConversation ? groupMessageList.length : messageList.length;

    return AppSurfaceCard(
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(normal * 1.6),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.surface.withValues(alpha: 0.92),
                Theme.of(context).colorScheme.surface.withValues(alpha: 0.82),
              ],
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.fromLTRB(normal, normal, normal, low * 0.85),
                child: Row(
                  children: [
                    Text(
                      isGroupConversation
                          ? LocaleKeys.chat_group_flow.tr()
                          : LocaleKeys.chat_message_flow.tr(),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: normal * 0.75,
                        vertical: low * 0.72,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(normal * 1.2),
                      ),
                      child: Text(
                        LocaleKeys.general_count_message.tr(
                          namedArgs: {'count': '$itemCount'},
                        ),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: _buildBody(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;

    if (isLoading) {
      return const Center(
        child: CustomLoader(),
      );
    }

    if (isGroupConversation && groupMessageList.isEmpty) {
      return _ChatEmptyState(
        icon: Icons.groups_outlined,
        title: LocaleKeys.chat_empty_group_title.tr(),
        message: LocaleKeys.chat_empty_group_message.tr(),
      );
    }

    if (!isGroupConversation && messageList.isEmpty) {
      return _ChatEmptyState(
        icon: Icons.chat_bubble_outline_rounded,
        title: LocaleKeys.chat_empty_direct_title.tr(),
        message: LocaleKeys.chat_empty_direct_message.tr(),
      );
    }

    return ListView.builder(
      controller: scrollController,
      reverse: true,
      padding: EdgeInsets.fromLTRB(normal, normal, normal, low * 1.2),
      itemCount:
          isGroupConversation ? groupMessageList.length : messageList.length,
      itemBuilder: (context, index) {
        if (isGroupConversation) {
          final reversedIndex = groupMessageList.length - 1 - index;
          final message = groupMessageList[reversedIndex];
          final isMe = message.fromUserId == currentUserId;
          final decryptedText = decryptMessageSafe(message.messageText ?? '');
          return GroupMessageContainerWidget(
            userName: message.fromUserName ?? '',
            isMe: isMe,
            date: message.sentOn ?? '',
            message: decryptedText,
          );
        }

        final reversedIndex = messageList.length - 1 - index;
        final message = messageList[reversedIndex];
        final isMe = message.fromUserId == currentUserId;
        final decryptedText = decryptMessageSafe(message.messageText ?? '');
        return MessageContainerWidget(
          isMe: isMe,
          date: message.sentAt ?? '',
          message: decryptedText,
        );
      },
    );
  }
}

class _ChatEmptyState extends StatelessWidget {
  const _ChatEmptyState({
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(context.sized.normalValue),
        child: AppEmptyStateCard(
          icon: icon,
          title: title,
          message: message,
        ),
      ),
    );
  }
}
