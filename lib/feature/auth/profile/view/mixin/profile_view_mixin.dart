import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hipocapp/feature/auth/profile/view/profil_view.dart';
import 'package:hipocapp/feature/auth/profile/view_model/profile_view_model.dart';
import 'package:hipocapp/product/service/entry_service.dart';
import 'package:hipocapp/product/service/manager/product_network_error_manager.dart';
import 'package:hipocapp/product/service/profile_service.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/state/container/product_satate_items.dart';
import 'package:image_picker/image_picker.dart';

mixin ProfileViewMixin on BaseState<ProfilView> {
  late final ProductNetworkErrorManager _productNetworkErrorManager;
  late final ProfileViewModel _profileViewModel;

  late final TextEditingController nameController;
  late final TextEditingController surnameController;
  late final TextEditingController usernameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController passwordReController;

  late final TextEditingController passwordChangeController;
  late final TextEditingController newPasswordChangeController;
  late final TextEditingController newPasswordReChangeController;

  ProfileViewModel get profileViewModel => _profileViewModel;
  @override
  void initState() {
    super.initState();
    _productNetworkErrorManager = ProductNetworkErrorManager(context: context);
    ProductStateItems.productNetworkManager.listenErrorState(onErrorStatus: _productNetworkErrorManager.handleError);
    _profileViewModel = ProfileViewModel(
      productViewModel: productViewModel,
      profileOperation: ProfileService(ProductStateItems.productNetworkManager),
      entryOperation: EntryService(ProductStateItems.productNetworkManager),
    );
    _profileViewModel.getProfile(productViewModel.state.currentUserId!);
    nameController = TextEditingController();
    surnameController = TextEditingController();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordReController = TextEditingController();
    passwordChangeController = TextEditingController();
    newPasswordChangeController = TextEditingController();
    newPasswordReChangeController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordReController.dispose();
    passwordChangeController.dispose();
    newPasswordChangeController.dispose();
    newPasswordReChangeController.dispose();
    super.dispose();
  }

  /// Pick a photo from the device gallery and update the selected photo in the view model.
  ///
  /// Returns the selected photo as a [File] if a photo is selected, otherwise null.
  Future<File?> pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      profileViewModel.updateSelectedPhoto(file);
      return file;
    }
    return null;
  }
}
