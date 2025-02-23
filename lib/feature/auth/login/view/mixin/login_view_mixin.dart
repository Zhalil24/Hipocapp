import 'package:my_architecture_template/feature/auth/login/view/login_view.dart';
import 'package:my_architecture_template/feature/auth/login/view_model/login_view_model.dart';
import 'package:my_architecture_template/product/service/login_service.dart';
import 'package:my_architecture_template/product/service/manager/product_network_error_manager.dart';
import 'package:my_architecture_template/product/state/base/base_state.dart';
import 'package:my_architecture_template/product/state/container/product_satate_items.dart';

mixin LoginViewMixin on BaseState<LoginView> {
  late final ProductNetworkErrorManager _productNetworkErrorManager;
  late final LoginViewModel _loginViewModel;

  LoginViewModel get loginViewModel => _loginViewModel;
  @override
  void initState() {
    super.initState();
    _productNetworkErrorManager = ProductNetworkErrorManager(context: context);
    ProductStateItems.productNetworkManager.listenErrorState(onErrorStatus: _productNetworkErrorManager.handleError);
    _loginViewModel = LoginViewModel(
      operationService: LoginService(ProductStateItems.productNetworkManager),
      userCacheOperation: ProductStateItems.productCache.userCacheOperation,
    );
  }
}
