import 'package:flutter/material.dart';
import 'package:hipocapp/feature/drawer/view/drawer_view.dart';
import 'package:hipocapp/feature/drawer/view_model/drawer_view_model.dart';
import 'package:hipocapp/product/service/entry_service.dart';
import 'package:hipocapp/product/service/header_service.dart';
import 'package:hipocapp/product/service/manager/product_network_error_manager.dart';
import 'package:hipocapp/product/service/title_service.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/state/container/product_satate_items.dart';

mixin DrawerViewMixin on BaseState<DrawerView> {
  late final ProductNetworkErrorManager _productNetworkErrorManager;
  late final DrawerViewModel _drawerViewModel;

  DrawerViewModel get drawerViewModel => _drawerViewModel;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _productNetworkErrorManager = ProductNetworkErrorManager(context: context);
    ProductStateItems.productNetworkManager.listenErrorState(onErrorStatus: _productNetworkErrorManager.handleError);
    _drawerViewModel = DrawerViewModel(
        headerOperation: HeaderService(ProductStateItems.productNetworkManager),
        enryOperation: EntryService(ProductStateItems.productNetworkManager),
        titleOperation: TitleService(ProductStateItems.productNetworkManager));
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }
}
