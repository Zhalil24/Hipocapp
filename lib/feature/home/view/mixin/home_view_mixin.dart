import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hipocapp/feature/home/view/home_view.dart';
import 'package:hipocapp/feature/home/view_model/home_view_model.dart';
import 'package:hipocapp/product/service/content_service.dart';
import 'package:hipocapp/product/service/group_list_service.dart';
import 'package:hipocapp/product/service/last_entries_service.dart';
import 'package:hipocapp/product/service/manager/product_network_error_manager.dart';
import 'package:hipocapp/product/service/random_entries_servise.dart';
import 'package:hipocapp/product/service/title_service.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/state/container/product_satate_items.dart';

mixin HomeViewMixin on BaseState<HomeView> {
  late final ProductNetworkErrorManager _productNetworkErrorManager;
  late final HomeViewModel _homeViewModel;
  late final TextEditingController textController;
  late Timer? timer;

  HomeViewModel get homeViewModel => _homeViewModel;
  late final ScrollController scrollController = ScrollController();
  bool isBottomBarVisible = true;

  @override
  void initState() {
    super.initState();
    _productNetworkErrorManager = ProductNetworkErrorManager(context: context);
    ProductStateItems.productNetworkManager.listenErrorState(onErrorStatus: _productNetworkErrorManager.handleError);
    _homeViewModel = HomeViewModel(
        lastEntriesOperation: LastEntriesService(ProductStateItems.productNetworkManager),
        groupListOperation: GroupListService(ProductStateItems.productNetworkManager),
        randomEntryOperation: RandomEntriesService(ProductStateItems.productNetworkManager),
        contentOperation: ContentService(ProductStateItems.productNetworkManager),
        titleOperation: TitleService(ProductStateItems.productNetworkManager));
    _homeViewModel.changeEntries(true);
    textController = TextEditingController();
    _homeViewModel.getGroupList();
    timer = null;
  }

  @override
  void dispose() {
    textController.dispose();
    scrollController.dispose();
    timer?.cancel();
    super.dispose();
  }
}
