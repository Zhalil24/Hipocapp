import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/cache/model/onboarding_cache_model.dart';
import 'package:hipocapp/product/cache/model/theme_cache_model.dart';
import 'package:hipocapp/product/cache/model/user_cache_model.dart';
import 'package:hipocapp/product/state/base/base_cuibt.dart';
import 'package:hipocapp/product/state/view_model/prodcut_state.dart';

final class ProductViewModel extends BaseCubit<ProdcutState> {
  ProductViewModel({
    required this.themeCache,
    required this.userCache,
    required this.onboardingCache,
  }) : super(const ProdcutState());

  final SharedCacheOperation<ThemeCacheModel> themeCache;
  final SharedCacheOperation<UserCacheModel> userCache;
  final SharedCacheOperation<OnboardingCacheModel> onboardingCache;

  /// Change theme mode and cache it to local storage
  ///
  /// [themeMode] is the new theme mode
  ///
  /// Emits new [ProdcutState] with the new theme mode
  ///
  /// Adds the new theme mode to the local storage
  Future<void> changeThemeMode(ThemeMode themeMode) async {
    emit(state.copyWith(themeMode: themeMode));
    final idx = themeMode == ThemeMode.dark ? 1 : 0;
    final model = ThemeCacheModel(themeIndex: idx);
    await themeCache.add(model);
  }

  /// Loads the cached theme mode from local storage.
  ///
  /// Retrieves the theme data using the default ID from the cache. If the data
  /// is valid, it deserializes it into a `ThemeCacheModel`. The theme mode
  /// from the model is then used to update the current state.

  Future<void> loadCachedTheme() async {
    final id = const ThemeCacheModel.empty().id;
    final raw = await themeCache.get(id);
    final ThemeCacheModel model;
    if (raw != null) {
      model = raw;
    } else {
      model = const ThemeCacheModel.empty();
    }
    emit(state.copyWith(themeMode: model.themeMode));
  }

  /// Retrieves the user id from the cache and updates the current user id state.
  ///
  /// Emits a new [ProdcutState] with the user id from the cache.
  ///
  /// Returns the user id from the cache.
  Future<int> _getUserId() async {
    final cachedUser = await userCache.get('user_token');
    final userId = cachedUser!.userId;
    final userName = cachedUser.userName;
    emit(state.copyWith(currentUserId: userId, userName: userName));
    return userId;
  }

  /// Initializes the auth state by checking if the user token is cached.
  ///
  /// If the user token is cached and not empty, it sets the auth state to be logged in.
  /// Otherwise, it sets the auth state to be logged out.
  Future<void> initializeAuthState() async {
    final cachedUser = await userCache.get('user_token');
    if (cachedUser != null && cachedUser.token.isNotEmpty) {
      emit(state.copyWith(isLogin: true));
      await _getUserId();
    } else {
      emit(state.copyWith(isLogin: false));
    }
  }

  /// Emits a new [ProdcutState] with the login state set to true
  /// and the current user id from the cache.
  ///
  /// Returns the user id from the cache.
  Future<int> onLoginSuccess() async {
    emit(state.copyWith(isLogin: true));
    final userId = await _getUserId();
    return userId;
  }

  /// Logs out the user by emitting a new state with the login state set to false
  /// and the current user id set to 0.
  ///
  /// Also, removes the user token from the cache.
  ///
  /// Returns a Future<void> that resolves when the logout operation is complete.
  Future<void> onLogout() async {
    emit(state.copyWith(isLogin: false, currentUserId: 0, userName: ''));
    await userCache.remove('user_token');
  }

  /// Hides the onboarding screen by setting [showOnboarding] to false in the
  Future<void> hideOnboarding() async {
    final id = const OnboardingCacheModel.empty().id;
    final raw = await onboardingCache.get(id);
    final model = raw?.copyWith(showOnboarding: false) ?? const OnboardingCacheModel.empty().copyWith(showOnboarding: false);
    await onboardingCache.add(model);
  }
}
