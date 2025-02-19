import 'package:flutter/material.dart';
import 'package:my_architecture_template/product/state/base/base_cuibt.dart';
import 'package:my_architecture_template/product/state/view_model/prodcut_state.dart';

final class ProductViewModel extends BaseCubit<ProdcutState> {
  ProductViewModel() : super(const ProdcutState());

  /// Change theme mode
  void changeThemeMode(ThemeMode themeMode) {
    emit(state.copyWith(themeMode: themeMode));
  }
}
