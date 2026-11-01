import 'dart:async';

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
  late final FocusNode inputFocusNode;
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    inputFocusNode = FocusNode();
    scrollController = ScrollController();
    _productNetworkErrorManager = ProductNetworkErrorManager(context: context);
    ProductStateItems.productNetworkManager.listenErrorState(
      onErrorStatus: _productNetworkErrorManager.handleError,
    );
    _chatViewModel = ChatViewModel(
      toUserId: widget.toUserId ?? 0,
      manageSignalRLifecycle: widget.manageSignalRLifecycle,
      hubConnection: ProductStateItems.signalRService.connection,
      userCacheOperation: ProductStateItems.productCache.userCacheOperation,
      messageOperation: MessageService(ProductStateItems.productNetworkManager),
    );

    unawaited(
      Future.microtask(() async {
        await chatViewModel.initialize(
          groupId: widget.groupId,
          toUserId: widget.toUserId,
        );
        scrollToLatest(animated: false);
      }),
    );
  }

  Future<void> sendCurrentMessage() async {
    final plainText = controller.text.trim();
    if (plainText.isEmpty) {
      return;
    }

    if (widget.groupId == null) {
      await chatViewModel.sendPrivateMessage(
        toUserId: widget.toUserId ?? 0,
        messageText: plainText,
      );
    } else {
      await chatViewModel.sendMessageGroup(
        groupId: widget.groupId ?? 0,
        message: plainText,
      );
    }
    controller.clear();
    if (mounted) {
      inputFocusNode.requestFocus();
      scrollToLatest();
    }
  }

  void scrollToLatest({
    bool animated = true,
  }) {
    if (!scrollController.hasClients) {
      return;
    }
    const offset = 0.0;
    if (!animated) {
      scrollController.jumpTo(offset);
      return;
    }
    unawaited(
      scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    inputFocusNode.dispose();
    scrollController.dispose();
    unawaited(
      chatViewModel.disposeLifecycle(
        groupId: widget.groupId,
      ),
    );
    super.dispose();
  }
}
