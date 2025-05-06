import 'package:hipocapp/feature/auth/forgot_password/view_model/state/forgot_password_view_state.dart';
import 'package:hipocapp/product/service/interface/authentication_operation.dart';
import 'package:hipocapp/product/state/base/base_cuibt.dart';

final class ForgotPasswordViewModel extends BaseCubit<ForgotPasswordViewState> {
  ForgotPasswordViewModel({
    required AuthenticationOperation operationService,
  })  : _authenticationOperationService = operationService,
        super(ForgotPasswordViewState(isLoading: false));

  late final AuthenticationOperation _authenticationOperationService;

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

  Future<void> forgotPassword(String email) async {
    changeLoading();
    var resp = await _authenticationOperationService.forgotPasswordService(email);
    setServiceRespnonse(resp?.message);
    changeLoading();
  }
}
