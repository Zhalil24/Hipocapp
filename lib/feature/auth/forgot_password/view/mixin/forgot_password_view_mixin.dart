import 'package:hipocapp/feature/auth/forgot_password/view/forgot_password_view.dart';
import 'package:hipocapp/feature/auth/forgot_password/view_model/forgot_password_view_model.dart';
import 'package:hipocapp/product/service/auth_service.dart';
import 'package:hipocapp/product/service/manager/product_network_error_manager.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/state/container/product_satate_items.dart';

mixin ForgotPasswordViewMixin on BaseState<ForgotPasswordView> {
  late final ProductNetworkErrorManager _productNetworkErrorManager;
  late final ForgotPasswordViewModel _forgotPasswordViewModel;

  ForgotPasswordViewModel get forgotPasswordViewModel => _forgotPasswordViewModel;
  @override
  void initState() {
    super.initState();
    _productNetworkErrorManager = ProductNetworkErrorManager(context: context);
    ProductStateItems.productNetworkManager.listenErrorState(onErrorStatus: _productNetworkErrorManager.handleError);
    _forgotPasswordViewModel = ForgotPasswordViewModel(
      operationService: LoginService(ProductStateItems.productNetworkManager),
    );
  }
}
