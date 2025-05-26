import 'package:hipocapp/feature/auth/register/view_model/state/register_view_state.dart';
import 'package:hipocapp/product/service/interface/degree_operation.dart';
import 'package:hipocapp/product/state/base/base_cuibt.dart';

final class RegisterViewModel extends BaseCubit<RegisterViewState> {
  RegisterViewModel({
    required DegreeOperation degreeOperation,
  })  : _degreeOperation = degreeOperation,
        super(RegisterViewState(isLoading: false));

  late final DegreeOperation _degreeOperation;

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
}
