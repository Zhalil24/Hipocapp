import 'package:core/core.dart';
import 'package:hipocapp/feature/splash/view_model/state/splah_view_state.dart';
import 'package:hipocapp/product/cache/model/user_cache_model.dart';
import '../../../product/state/base/base_cuibt.dart';

final class SplashViewModel extends BaseCubit<SplashViewState> {
  SplashViewModel({
    required HiveCacheOperation<UserCacheModel> userCacheOperation,
  })  : _userCacheOperation = userCacheOperation,
        super(SplashViewState(isLoading: false, isLoggedIn: false)) {
    checkLoginStatus();
  }

  late final HiveCacheOperation<UserCacheModel> _userCacheOperation;

  /// Check if the user is logged in or not.
  void checkLoginStatus() {
    final cachedUser = _userCacheOperation.get('user_token');
    final isLoggedIn = cachedUser?.token.isNotEmpty ?? false;
    emit(state.copyWith(isLoggedIn: isLoggedIn));
  }
}
