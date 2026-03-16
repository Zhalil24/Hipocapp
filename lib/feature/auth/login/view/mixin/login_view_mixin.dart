import 'package:flutter/material.dart';
import 'package:hipocapp/feature/auth/login/view/login_view.dart';
import 'package:hipocapp/feature/auth/login/view_model/login_view_model.dart';
import 'package:hipocapp/product/service/auth_service.dart';
import 'package:hipocapp/product/service/manager/product_network_error_manager.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/state/container/product_satate_items.dart';

mixin LoginViewMixin on BaseState<LoginView> {
  late final ProductNetworkErrorManager _productNetworkErrorManager;
  late final LoginViewModel _loginViewModel;
  late final TextEditingController userNameController;
  late final TextEditingController passwordController;

  LoginViewModel get loginViewModel => _loginViewModel;
  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
    passwordController = TextEditingController();
    _productNetworkErrorManager = ProductNetworkErrorManager(context: context);
    ProductStateItems.productNetworkManager.listenErrorState(onErrorStatus: _productNetworkErrorManager.handleError);
    _loginViewModel = LoginViewModel(
      productViewModel: productViewModel,
      operationService: LoginService(ProductStateItems.productNetworkManager),
      userCacheOperation: ProductStateItems.productCache.userCacheOperation,
    );
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
