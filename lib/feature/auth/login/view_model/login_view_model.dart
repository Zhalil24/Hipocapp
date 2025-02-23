import 'package:core/core.dart';
import 'package:gen/gen.dart';
import 'package:my_architecture_template/feature/auth/login/view_model/state/login_view_state.dart';
import 'package:my_architecture_template/product/cache/model/user_cache_model.dart';
import 'package:my_architecture_template/product/service/interface/authentication_operation.dart';
import 'package:my_architecture_template/product/state/base/base_cuibt.dart';

final class LoginViewModel extends BaseCubit<LoginViewState> {
  LoginViewModel({
    required AuthenticationOperation operationService,
    required HiveCacheOperation<UserCacheModel> userCacheOperation,
  })  : _authenticationOperationService = operationService,
        _userCacheOperation = userCacheOperation,
        super(LoginViewState(isLoading: false));

  late final AuthenticationOperation _authenticationOperationService;
  late final HiveCacheOperation<UserCacheModel> _userCacheOperation;

  /// Change loading state
  void changeLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  Future<void> fetchLogin({required String userName, required String password}) async {
    final userLoginModel = UserLoginModel(
      userName: userName,
      password: password,
    );

    final response = await _authenticationOperationService.userLogin(userLoginModel: userLoginModel);
    print(response?.accessToken);

    changeLoading();
  }
}
