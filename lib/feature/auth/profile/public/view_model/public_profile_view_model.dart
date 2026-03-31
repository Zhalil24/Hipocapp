import 'package:hipocapp/feature/auth/profile/public/view_model/state/public_profile_view_state.dart';
import 'package:hipocapp/product/service/interface/user_operation.dart';
import 'package:hipocapp/product/state/base/base_cuibt.dart';

final class PublicProfileViewModel extends BaseCubit<PublicProfileViewState> {
  PublicProfileViewModel({
    required UserOperation userOperation,
  })  : _userOperation = userOperation,
        super(const PublicProfileViewState(isLoading: false));

  final UserOperation _userOperation;

  Future<void> getProfile(int userId) async {
    emit(state.copyWith(isLoading: true));
    final response = await _userOperation.getUserById(userId);
    emit(
      state.copyWith(
        isLoading: false,
        profileModel: response?.profileModel,
      ),
    );
  }
}
