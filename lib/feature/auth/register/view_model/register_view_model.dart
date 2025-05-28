import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/feature/auth/register/view_model/state/register_view_state.dart';
import 'package:hipocapp/product/navigation/app_router.dart';
import 'package:hipocapp/product/service/interface/authentication_operation.dart';
import 'package:hipocapp/product/service/interface/degree_operation.dart';
import 'package:hipocapp/product/state/base/base_cuibt.dart';

final class RegisterViewModel extends BaseCubit<RegisterViewState> {
  RegisterViewModel({
    required DegreeOperation degreeOperation,
    required AuthenticationOperation authenticationOperation,
  })  : _degreeOperation = degreeOperation,
        _authenticationOperation = authenticationOperation,
        super(RegisterViewState(isLoading: false, isCheck: false));

  late final DegreeOperation _degreeOperation;
  late final AuthenticationOperation _authenticationOperation;
  File? selectedPhoto;

  /// Change loading state
  void changeLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  /// Clear service message
  void clearServiceMessage() {
    emit(state.copyWith(serviceResponseMessage: null));
  }

  /// Set service response
  void setServiceRespnonse(String? message) {
    emit(state.copyWith(serviceResponseMessage: message));
  }

  /// Set selected photo
  void updateSelectedPhoto(File photo) {
    selectedPhoto = photo;
    emit(state.copyWith(photo: photo));
  }

  /// Updates the degree id in the state with the given [degreeId].
  ///
  /// This is used to keep track of the currently selected degree id.
  void updateDegreeId(int degreeId) {
    emit(state.copyWith(degreeId: degreeId));
  }

  /// Updates the state's isCheck with the given [value].
  ///
  /// This is used to keep track of whether the user has checked the terms and
  /// conditions box or not.
  void updateIsCheck(bool value) {
    emit(state.copyWith(isCheck: value));
  }

  /// Fetches the degree information from the server and updates the state.
  ///
  /// This method toggles the loading state before and after the fetch operation.
  /// After fetching the degree data from the server, it updates the state's degree
  /// with the fetched data.

  Future<void> getDegree() async {
    changeLoading();
    final resp = await _degreeOperation.getDegree();
    emit(state.copyWith(degree: resp?.degree));
    changeLoading();
  }

  /// Registers a new user with the provided [model].
  ///
  /// This method toggles the loading state before and after the registration operation.
  /// After attempting to register the user, it sets the service response message
  /// based on the result of the operation.

  Future<bool> userRegister(
    String name,
    String username,
    String surname,
    String password,
    String rePassword,
    String phone,
    String email,
    bool isTermsAccepted,
    BuildContext context,
  ) async {
    changeLoading();
    final model = UserRegisterModel(
      degreeId: state.degreeId,
      email: email,
      identityNumber: 'a',
      image: state.photo,
      isTermsAccepted: isTermsAccepted,
      name: name,
      password: password,
      phoneNumber: phone,
      passwordRepeat: rePassword,
      surname: surname,
      username: username,
      imageURL: 'a',
    );
    final resp = await _authenticationOperation.userRegister(model);
    if (resp != null && resp.message != null) {
      setServiceRespnonse(resp.message);
      if (resp.isSuccess == true) {
        await context.router.replaceAll([
          const LoginRoute(),
        ]);
      }
      ;
      changeLoading();
      return true;
    } else {
      changeLoading();
      setServiceRespnonse('Tekrar Deneyiniz');
      return false;
    }
  }
}
