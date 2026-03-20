import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hipocapp/feature/chat/view/mixin/chat_view_mixin.dart';
import 'package:hipocapp/feature/chat/view/widget/chat_app_bar.dart';
import 'package:hipocapp/feature/chat/view/widget/chat_background_widget.dart';
import 'package:hipocapp/feature/chat/view/widget/chat_page_content_widget.dart';
import 'package:hipocapp/feature/chat/view_model/chat_view_model.dart';
import 'package:hipocapp/feature/chat/view_model/state/chat_view_state.dart';
import 'package:hipocapp/product/state/base/base_state.dart';

@RoutePage()
class ChatView extends StatefulWidget {
  const ChatView({
    super.key,
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
  @override
  Widget build(BuildContext context) {
    final isGroupConversation = widget.groupId != null;

    return BlocProvider(
      create: (context) => chatViewModel,
      child: BlocListener<ChatViewModel, ChatViewState>(
        listenWhen: (prev, curr) =>
            prev.isLoading != curr.isLoading ||
            (prev.messageList?.length ?? 0) !=
                (curr.messageList?.length ?? 0) ||
            (prev.groupMessageList?.length ?? 0) !=
                (curr.groupMessageList?.length ?? 0),
        listener: (context, state) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) {
              return;
            }
            scrollToLatest(animated: !state.isLoading);
          });
        },
        child: Stack(
          children: [
            const Positioned.fill(
              child: ChatBackgroundWidget(),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: ChatAppBar(
                userName: widget.toUserName ?? '',
                groupName: widget.groupName,
                isOnline: widget.isOnline ?? false,
                showOnlineStatus: !isGroupConversation,
              ),
              resizeToAvoidBottomInset: true,
              body: BlocBuilder<ChatViewModel, ChatViewState>(
                builder: (context, state) {
                  return ChatPageContentWidget(
                    state: state,
                    isGroupConversation: isGroupConversation,
                    controller: controller,
                    focusNode: inputFocusNode,
                    scrollController: scrollController,
                    onSend: sendCurrentMessage,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
