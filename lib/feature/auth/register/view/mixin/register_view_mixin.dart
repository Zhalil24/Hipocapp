import 'package:flutter/material.dart';
import 'package:hipocapp/feature/auth/register/view/register_view.dart';
import 'package:hipocapp/feature/auth/register/view_model/register_view_model.dart';
import 'package:hipocapp/product/service/degree_service.dart';
import 'package:hipocapp/product/service/manager/product_network_error_manager.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/state/container/product_satate_items.dart';

mixin RegisterViewMixin on BaseState<RegisterView> {
  late final ProductNetworkErrorManager _productNetworkErrorManager;
  late final RegisterViewModel _registerViewModel;
  late final TextEditingController nameController;
  late final TextEditingController surnameController;
  late final TextEditingController usernameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController passwordController;
  late final TextEditingController rePasswordController;
  RegisterViewModel get registerViewModel => _registerViewModel;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    surnameController = TextEditingController();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();

    _productNetworkErrorManager = ProductNetworkErrorManager(context: context);
    ProductStateItems.productNetworkManager.listenErrorState(
      onErrorStatus: _productNetworkErrorManager.handleError,
    );
    _registerViewModel = RegisterViewModel(
        degreeOperation: DegreeService(
      ProductStateItems.productNetworkManager,
    ));

    registerViewModel.getDegree();
  }
}
