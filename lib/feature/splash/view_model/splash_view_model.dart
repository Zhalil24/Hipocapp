import 'package:core/core.dart';
import 'package:hipocapp/feature/splash/view_model/state/splah_view_state.dart';
import 'package:hipocapp/product/cache/model/onboarding_cache_model.dart';
import 'package:hipocapp/product/cache/model/user_cache_model.dart';
import '../../../product/state/base/base_cuibt.dart';

final class SplashViewModel extends BaseCubit<SplashViewState> {
  SplashViewModel({
    required SharedCacheOperation<UserCacheModel> userCacheOperation,
    required SharedCacheOperation<OnboardingCacheModel> onboardingCacheOperation,
  })  : _userCacheOperation = userCacheOperation,
        _onboardingCacheOperation = onboardingCacheOperation,
        super(SplashViewState(isLoading: false, isLoggedIn: false)) {
    checkLoginStatus();
  }

  late final SharedCacheOperation<UserCacheModel> _userCacheOperation;
  late final SharedCacheOperation<OnboardingCacheModel> _onboardingCacheOperation;

  /// Check if the user is logged in or not.
  Future<void> checkLoginStatus() async {
    final cachedUser = await _userCacheOperation.get('user_token');
    final isLoggedIn = cachedUser?.token.isNotEmpty ?? false;
    emit(state.copyWith(isLoggedIn: isLoggedIn));
  }

  /// Retrieves the onboarding cache from the local storage.
  ///
  /// Returns a [Future] that resolves with the onboarding cache model
  /// from the local storage. If the cache is not found, it returns null.
  Future<OnboardingCacheModel?> getOnBoardingCache() async {
    final id = const OnboardingCacheModel.empty().id;
    final raw = await _onboardingCacheOperation.get(id);
    return raw;
  }
}
