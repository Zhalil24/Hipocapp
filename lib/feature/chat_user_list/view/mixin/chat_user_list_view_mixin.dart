import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hipocapp/feature/chat_user_list/view/chat_user_list_view.dart';
import 'package:hipocapp/feature/chat_user_list/view_model/chat_user_list_view_model.dart';
import 'package:hipocapp/product/service/follow_service.dart';
import 'package:hipocapp/product/service/manager/product_network_error_manager.dart';
import 'package:hipocapp/product/service/message_service.dart';
import 'package:hipocapp/product/service/user_service.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/state/container/product_satate_items.dart';

mixin ChatUserListViewMixin on BaseState<ChatUserListView> {
  late final ProductNetworkErrorManager _productNetworkErrorManager;
  late final ChatUserListViewModel _chatUserListViewModel;

  ChatUserListViewModel get chatUserListViewModel => _chatUserListViewModel;

  @override
  void initState() {
    super.initState();
    _productNetworkErrorManager = ProductNetworkErrorManager(context: context);
    ProductStateItems.productNetworkManager.listenErrorState(
      onErrorStatus: _productNetworkErrorManager.handleError,
    );
    _chatUserListViewModel = ChatUserListViewModel(
      userCacheOperation: ProductStateItems.productCache.userCacheOperation,
      userOperation: UserService(ProductStateItems.productNetworkManager),
      hubConnection: ProductStateItems.signalRService.connection,
      messageOperation: MessageService(ProductStateItems.productNetworkManager),
      followOperation: FollowService(ProductStateItems.productNetworkManager),
    );

    final initialQuery = widget.query?.trim() ?? '';
    unawaited(
      Future.microtask(() async {
        await chatUserListViewModel.initialize(
          initialTab: widget.tab,
          initialQuery: initialQuery,
        );
      }),
    );
  }

  @override
  void dispose() {
    unawaited(chatUserListViewModel.disconnect());
    super.dispose();
  }
}
