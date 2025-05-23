import 'package:flutter/material.dart';
import 'package:hipocapp/feature/chat/view/chat_view.dart';
import 'package:hipocapp/feature/chat/view_model/chat_view_model.dart';
import 'package:hipocapp/product/service/manager/product_network_error_manager.dart';
import 'package:hipocapp/product/service/message_service.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/state/container/product_satate_items.dart';

mixin ChatViewMixin on BaseState<ChatView> {
  late final ProductNetworkErrorManager _productNetworkErrorManager;
  late final ChatViewModel _chatViewModel;

  ChatViewModel get chatViewModel => _chatViewModel;
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    _productNetworkErrorManager = ProductNetworkErrorManager(context: context);
    ProductStateItems.productNetworkManager.listenErrorState(onErrorStatus: _productNetworkErrorManager.handleError);
    _chatViewModel = ChatViewModel(
      toUserId: widget.toUserId ?? 0,
      hubConnection: ProductStateItems.signalRService.connection,
      userCacheOperation: ProductStateItems.productCache.userCacheOperation,
      messageOperation: MessageService(ProductStateItems.productNetworkManager),
    );

    if (widget.groupId != null) {
      chatViewModel.getGroupMessage(widget.groupId!);
    } else {
      final toUserId = widget.toUserId ?? 0;
      chatViewModel
        ..getMessageList(toUserId)
        ..markMessage(toUserId);
    }

    chatViewModel.startListeningMessages();
  }

  @override
  void dispose() {
    controller.dispose();
    chatViewModel.leaveGroup(widget.groupName ?? '');
    super.dispose();
  }
}
