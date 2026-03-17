import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hipocapp/feature/entry_list/view/entry_list_view.dart';
import 'package:hipocapp/feature/entry_list/view_model/entry_list_view_model.dart';
import 'package:hipocapp/product/service/entry_list_service.dart';
import 'package:hipocapp/product/service/entry_service.dart';
import 'package:hipocapp/product/service/manager/product_network_error_manager.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/state/container/product_satate_items.dart';

mixin EntryListViewMixin on BaseState<EntryListView> {
  late final ProductNetworkErrorManager _productNetworkErrorManager;
  late final EntryListViewModel _entryListViewModel;
  late final TextEditingController entryController;
  late final GlobalKey<FormState> formKey;
  late final FocusNode entryFocusNode;

  EntryListViewModel get entryListViewModel => _entryListViewModel;

  @override
  void initState() {
    super.initState();
    _productNetworkErrorManager = ProductNetworkErrorManager(context: context);
    ProductStateItems.productNetworkManager.listenErrorState(
      onErrorStatus: _productNetworkErrorManager.handleError,
    );
    _entryListViewModel = EntryListViewModel(
      entryListOperation:
          EntryListService(ProductStateItems.productNetworkManager),
      entryOperation: EntryService(ProductStateItems.productNetworkManager),
    );
    entryController = TextEditingController();
    formKey = GlobalKey<FormState>();
    entryFocusNode = FocusNode();
    unawaited(_entryListViewModel.getEntryList(widget.titleName));
  }

  Future<void> submitEntry() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    final currentUserId = productViewModel.state.currentUserId;
    if (currentUserId == null) return;

    final text = entryController.text.trim();
    if (text.isEmpty) return;

    await entryListViewModel.createEntry(
      widget.titleName,
      text,
      widget.headerId,
      currentUserId,
    );
    entryController.clear();
    entryFocusNode.unfocus();
  }

  @override
  void dispose() {
    entryController.dispose();
    entryFocusNode.dispose();
    super.dispose();
  }
}
