import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/feature/chat/view/widget/chat_composer_widget.dart';
import 'package:hipocapp/feature/chat/view/widget/chat_message_list_widget.dart';
import 'package:hipocapp/feature/chat/view_model/state/chat_view_state.dart';
import 'package:kartal/kartal.dart';

class ChatPageContentWidget extends StatelessWidget {
  const ChatPageContentWidget({
    super.key,
    required this.state,
    required this.isGroupConversation,
    required this.controller,
    required this.focusNode,
    required this.scrollController,
    required this.onSend,
  });

  final ChatViewState state;
  final bool isGroupConversation;
  final TextEditingController controller;
  final FocusNode focusNode;
  final ScrollController scrollController;
  final Future<void> Function() onSend;

  @override
  Widget build(BuildContext context) {
    final normal = context.sized.normalValue;

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              normal,
              normal * 0.7,
              normal,
              normal,
            ),
            child: ChatMessageListWidget(
              isLoading: state.isLoading,
              isGroupConversation: isGroupConversation,
              currentUserId: state.currentUserId,
              messageList: state.messageList ?? <MessageListModel>[],
              groupMessageList: state.groupMessageList ?? <GroupMessageModel>[],
              scrollController: scrollController,
            ),
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              normal,
              0,
              normal,
              normal,
            ),
            child: ChatComposerWidget(
              controller: controller,
              focusNode: focusNode,
              isGroupConversation: isGroupConversation,
              onSend: onSend,
            ),
          ),
        ),
      ],
    );
  }
}
