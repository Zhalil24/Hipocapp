import 'package:hipocapp/feature/drawer/view/drawer_view.dart';
import 'package:hipocapp/feature/drawer/view_model/drawer_view_model.dart';
import 'package:hipocapp/product/service/manager/product_network_error_manager.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/state/container/product_satate_items.dart';

import '../../../../product/service/random_entries_servise.dart';

mixin DrawerViewMixin on BaseState<DrawerView> {
  late final ProductNetworkErrorManager _productNetworkErrorManager;
  late final DrawerViewModel _drawerViewModel;

  DrawerViewModel get drawerViewModel => _drawerViewModel;
  @override
  void initState() {
    super.initState();
    _productNetworkErrorManager = ProductNetworkErrorManager(context: context);
    ProductStateItems.productNetworkManager.listenErrorState(onErrorStatus: _productNetworkErrorManager.handleError);
    _drawerViewModel = DrawerViewModel(
      randomEntryOperation: RandomEntriesService(ProductStateItems.productNetworkManager),
    );
  }
}
