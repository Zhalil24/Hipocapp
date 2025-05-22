import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/cache/model/theme_cache_model.dart';
import 'package:hipocapp/product/state/base/base_cuibt.dart';
import 'package:hipocapp/product/state/view_model/prodcut_state.dart';

final class ProductViewModel extends BaseCubit<ProdcutState> {
  ProductViewModel({
    required this.themeCache,
  }) : super(const ProdcutState());

  final HiveCacheOperation<ThemeCacheModel> themeCache;

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
    themeCache.add(model);
  }

  /// Loads the cached theme mode from local storage.
  ///
  /// Retrieves the theme data using the default ID from the cache. If the data
  /// is valid, it deserializes it into a `ThemeCacheModel`. The theme mode
  /// from the model is then used to update the current state.

  Future<void> loadCachedTheme() async {
    final id = const ThemeCacheModel.empty().id;
    final raw = themeCache.get(id);
    final ThemeCacheModel model;
    if (raw is ThemeCacheModel) {
      model = raw;
    } else {
      model = ThemeCacheModel.empty().fromDynamicJson(raw);
    }
    emit(state.copyWith(themeMode: model.themeMode));
  }
}
