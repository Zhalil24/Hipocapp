import 'package:hipocapp/feature/group_list/view/group_list_view.dart';
import 'package:hipocapp/feature/group_list/view_model/group_list_view_model.dart';
import 'package:hipocapp/product/service/group_list_service.dart';
import 'package:hipocapp/product/service/manager/product_network_error_manager.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/state/container/product_satate_items.dart';

mixin GroupListMixin on BaseState<GroupListView> {
  late final ProductNetworkErrorManager _productNetworkErrorManager;
  late final GroupListViewModel _groupListViewModel;

  GroupListViewModel get groupListViewModel => _groupListViewModel;
  @override
  void initState() {
    super.initState();
    _productNetworkErrorManager = ProductNetworkErrorManager(context: context);
    ProductStateItems.productNetworkManager.listenErrorState(onErrorStatus: _productNetworkErrorManager.handleError);
    _groupListViewModel = GroupListViewModel(
      groupListOperation: GroupListService(ProductStateItems.productNetworkManager),
    );
    _groupListViewModel.getGroupList();
  }
}
