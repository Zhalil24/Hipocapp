import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hipocapp/feature/auth/register/view/register_view.dart';
import 'package:hipocapp/feature/auth/register/view_model/register_view_model.dart';
import 'package:hipocapp/product/service/auth_service.dart';
import 'package:hipocapp/product/service/degree_service.dart';
import 'package:hipocapp/product/service/manager/product_network_error_manager.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/state/container/product_satate_items.dart';
import 'package:image_picker/image_picker.dart';

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
        ),
        authenticationOperation: LoginService(
          ProductStateItems.productNetworkManager,
        ));

    registerViewModel.getDegree();
  }

  /// Picks an image from the device's gallery, updates the selected photo in the view model,
  /// and returns the image as a [File].
  ///
  /// Returns the selected image as a [File] if an image is picked, otherwise returns null.
  /// This function utilizes the [ImagePicker] to select the image from the gallery and
  /// updates the [registerViewModel] with the selected image.

  Future<File?> pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      registerViewModel.updateSelectedPhoto(file);
      return file;
    }
    return null;
  }

  /// Toggles the value of [isCheck] and updates the UI accordingly.
  ///
  /// This method updates the state by inverting the current value of [isCheck],
  /// which can be used to manage the checked status of a checkbox or toggle
  /// button in the UI.

  void updateIsCheck(bool isCheck) {
    setState(() {
      isCheck = !isCheck;
    });
  }
}
