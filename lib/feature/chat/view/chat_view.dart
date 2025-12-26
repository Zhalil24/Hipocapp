import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hipocapp/feature/chat/view/mixin/chat_view_mixin.dart';
import 'package:hipocapp/feature/chat/view/widget/chat_app_bar.dart';
import 'package:hipocapp/feature/chat/view/widget/group_message_container_widget.dart';
import 'package:hipocapp/feature/chat/view/widget/input_area_widget.dart';
import 'package:hipocapp/feature/chat/view/widget/input_button_widget.dart';
import 'package:hipocapp/feature/chat/view/widget/message_container_widget.dart';
import 'package:hipocapp/feature/chat/view_model/chat_view_model.dart';
import 'package:hipocapp/feature/chat/view_model/state/chat_view_state.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/utility/decrypt/chat_crypto_utils.dart';
import 'package:hipocapp/product/widget/custom_loader/custom_loader_widget.dart';
import 'package:kartal/kartal.dart';

@RoutePage()
class ChatView extends StatefulWidget {
  const ChatView({
    this.toUserId,
    this.toUserName,
    this.isOnline,
    this.groupId,
    this.groupName,
  });
  final int? toUserId;
  final String? toUserName;
  final bool? isOnline;
  final int? groupId;
  final String? groupName;
  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends BaseState<ChatView> with ChatViewMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => chatViewModel,
      child: Scaffold(
        appBar: ChatAppBar(
          userName: widget.toUserName ?? '',
          groupName: widget.groupName,
          isOnline: widget.isOnline ?? false,
          showOnlineStatus: widget.groupId == null,
        ),
        resizeToAvoidBottomInset: true,
        body: BlocBuilder<ChatViewModel, ChatViewState>(
          builder: (context, state) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_scrollController.hasClients) {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                );
              }
            });

            return Column(
              children: [
                Expanded(
                  child: state.isLoading
                      ? const Center(child: CustomLoader())
                      : ListView.builder(
                          controller: _scrollController,
                          reverse: true,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          itemCount: (widget.groupId != null ? state.groupMessageList?.length : state.messageList?.length) ?? 0,
                          itemBuilder: (context, index) {
                            if (widget.groupId != null) {
                              final messages = state.groupMessageList;
                              final reversedIndex = (messages?.length ?? 0) - 1 - index;
                              final message = messages?[reversedIndex];
                              final isMe = message?.fromUserId == state.currentUserId;
                              final decryptedText = decryptMessageSafe(message?.messageText ?? '');
                              final date = message?.sentOn ?? '';
                              final userName = message?.fromUserName ?? '';
                              return _buildGroupMessageBubble(decryptedText, isMe, date, userName);
                            } else {
                              final messages = state.messageList;
                              final reversedIndex = (messages?.length ?? 0) - 1 - index;
                              final message = messages?[reversedIndex];
                              final isMe = message?.fromUserId == state.currentUserId;
                              final decryptedText = decryptMessageSafe(message?.messageText ?? '');
                              final date = message?.sentAt ?? '';
                              return _buildMessageBubble(decryptedText, isMe, date);
                            }
                          },
                        ),
                ),
                Padding(
                  padding: EdgeInsets.all(context.sized.normalValue),
                  child: _buildInputArea(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildMessageBubble(String text, bool isMe, String? date) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: MessageContainerWidget(
        isMe: isMe,
        date: date ?? '',
        message: text,
      ),
    );
  }

  Widget _buildGroupMessageBubble(String text, bool isMe, String? date, String userName) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GroupMessageContainerWidget(
        userName: userName,
        isMe: isMe,
        date: date ?? '',
        message: text,
      ),
    );
  }

  Widget _buildInputArea() {
    return Row(
      children: [
        Expanded(
          child: InputAreaWidget(
            controller: controller,
          ),
        ),
        InputButtonWidget(
          onPressed: () {
            final plainText = controller.text.trim();
            if (plainText.isEmpty) return;

            final encryptedMessage = encryptMessageSafe(plainText);
            if (widget.groupId == null) {
              chatViewModel.sendPrivateMessage(
                toUserId: widget.toUserId ?? 0,
                messageText: encryptedMessage,
              );
            } else {
              chatViewModel.sendMessageGroup(
                groupId: widget.groupId ?? 0,
                groupName: widget.groupName ?? '',
                message: encryptedMessage,
              );
            }
            controller.clear();

            // Mesaj gönderildiğinde otomatik scroll
            if (_scrollController.hasClients) {
              _scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
              );
            }
          },
        )
      ],
    );
  }
}
