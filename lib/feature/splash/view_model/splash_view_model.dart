import 'package:core/core.dart';
import 'package:hipocapp/feature/splash/view_model/state/splah_view_state.dart';
import 'package:hipocapp/product/cache/model/user_cache_model.dart';
import '../../../product/state/base/base_cuibt.dart';

final class SplashViewModel extends BaseCubit<SplashViewState> {
  SplashViewModel({
    required SharedCacheOperation<UserCacheModel> userCacheOperation,
  })  : _userCacheOperation = userCacheOperation,
        super(SplashViewState(isLoading: false, isLoggedIn: false)) {
    checkLoginStatus();
  }

  late final SharedCacheOperation<UserCacheModel> _userCacheOperation;

  /// Check if the user is logged in or not.
  Future<void> checkLoginStatus() async {
    final cachedUser = await _userCacheOperation.get('user_token');
    final isLoggedIn = cachedUser?.token.isNotEmpty ?? false;
    emit(state.copyWith(isLoggedIn: isLoggedIn));
  }
}
