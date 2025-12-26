import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/feature/auth/login/view_model/state/login_view_state.dart';
import 'package:hipocapp/product/cache/model/user_cache_model.dart';
import 'package:hipocapp/product/service/interface/authentication_operation.dart';
import 'package:hipocapp/product/state/base/base_cuibt.dart';
import 'package:hipocapp/product/state/view_model/product_view_model.dart';

import '../../../../product/navigation/app_router.dart';

final class LoginViewModel extends BaseCubit<LoginViewState> {
  LoginViewModel({
    required AuthenticationOperation operationService,
    required ProductViewModel productViewModel,
    required SharedCacheOperation<UserCacheModel> userCacheOperation,
  })  : _authenticationOperationService = operationService,
        _productViewModel = productViewModel,
        _userCacheOperation = userCacheOperation,
        super(LoginViewState(isLoading: false));

  late final AuthenticationOperation _authenticationOperationService;
  late final SharedCacheOperation<UserCacheModel> _userCacheOperation;
  late final ProductViewModel _productViewModel;

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

  Future<bool> fetchLogin({required String userName, required String password}) async {
    changeLoading();
    final userLoginModel = UserLoginModel(
      userName: userName,
      password: password,
    );
    final response = await _authenticationOperationService.userLogin(userLoginModel: userLoginModel);
    setServiceRespnonse(response?.message);
    if (response?.user != null) {
      await _saveItem(
        response?.user?.accessToken?.token ?? '',
        response?.user?.id ?? 0,
        response?.user?.username ?? '',
      );
      return true;
    }
    changeLoading();
    return false;
  }

  Future<bool> loginAndNavigate({
    required BuildContext context,
    required String userName,
    required String password,
  }) async {
    final isSuccess = await fetchLogin(
      userName: userName,
      password: password,
    );
    if (isSuccess && context.mounted) {
      await context.router.replace(const HomeRoute());
    }
    return isSuccess;
  }

  Future<void> _saveItem(String token, int userId, String userName) async {
    await _userCacheOperation.add(
      UserCacheModel(
        token: token,
        userId: userId,
        userName: userName,
      ),
    );
    await _productViewModel.onLoginSuccess();
  }
}
