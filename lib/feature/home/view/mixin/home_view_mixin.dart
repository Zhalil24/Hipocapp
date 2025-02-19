import 'package:my_architecture_template/feature/home/view/home_view.dart';
import 'package:my_architecture_template/feature/home/view_model/home_view_model.dart';
import 'package:my_architecture_template/product/service/login_service.dart';
import 'package:my_architecture_template/product/service/manager/product_network_error_manager.dart';
import 'package:my_architecture_template/product/state/base/base_state.dart';
import 'package:my_architecture_template/product/state/container/product_satate_items.dart';

mixin HomeViewMixin on BaseState<HomeView> {
  late final ProductNetworkErrorManager _productNetworkErrorManager;
  late final HomeViewModel _homeViewModel;

  HomeViewModel get homeViewModel => _homeViewModel;
  @override
  void initState() {
    super.initState();
    _productNetworkErrorManager = ProductNetworkErrorManager(context: context);
    ProductStateItems.productNetworkManager.listenErrorState(onErrorStatus: _productNetworkErrorManager.handleError);
    _homeViewModel = HomeViewModel(
      operationService: LoginService(productNetworkManager),
      userCacheOperation: ProductStateItems.productCache.userCacheOperation,
    );
  }
}
