import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hipocapp/feature/chat/view/mixin/chat_view_mixin.dart';
import 'package:hipocapp/feature/chat/view/widget/chat_app_bar.dart';
import 'package:hipocapp/feature/chat/view/widget/input_area_widget.dart';
import 'package:hipocapp/feature/chat/view/widget/input_button_widget.dart';
import 'package:hipocapp/feature/chat/view/widget/message_container_widget.dart';
import 'package:hipocapp/feature/chat/view_model/chat_view_model.dart';
import 'package:hipocapp/feature/chat/view_model/state/chat_view_state.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/utility/decrypt/chat_crypto_utils.dart';
import 'package:hipocapp/product/widget/custom_loader/custom_loader_widget.dart';

@RoutePage()
class ChatView extends StatefulWidget {
  const ChatView({required this.toUserId, required this.toUserName, this.isOnline});
  final int toUserId;
  final String? toUserName;
  final bool? isOnline;
  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends BaseState<ChatView> with ChatViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => chatViewModel,
      child: Scaffold(
        appBar: ChatAppBar(
          userName: widget.toUserName ?? '',
          isOnline: widget.isOnline ?? false,
        ),
        body: BlocBuilder<ChatViewModel, ChatViewState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: state.isLoading
                      ? const Center(child: CustomLoader())
                      : ListView.builder(
                          reverse: true,
                          itemCount: state.messageList?.length,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          itemBuilder: (context, index) {
                            final reversedIndex = (state.messageList?.length ?? 0) - 1 - index;
                            final message = state.messageList?[reversedIndex];
                            final currentUserId = state.currentUserId;
                            final isMe = message?.fromUserId == currentUserId;
                            final decryptedText = decryptMessageSafe(message?.messageText ?? '');
                            final date = message?.sentAt.toString();
                            return _buildMessageBubble(decryptedText, isMe, date);
                          },
                        ),
                ),
                const Divider(height: 1),
                _buildInputArea(),
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
        ));
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

            chatViewModel.sendPrivateMessage(
              toUserId: widget.toUserId,
              messageText: encryptedMessage,
            );

            controller.clear();
          },
        )
      ],
    );
  }
}
