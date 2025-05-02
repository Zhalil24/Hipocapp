import 'package:flutter/material.dart';
import 'package:hipocapp/product/state/base/base_cuibt.dart';
import 'package:hipocapp/product/state/view_model/prodcut_state.dart';

final class ProductViewModel extends BaseCubit<ProdcutState> {
  ProductViewModel() : super(const ProdcutState());

  /// Change theme mode
  void changeThemeMode(ThemeMode themeMode) {
    emit(state.copyWith(themeMode: themeMode));
  }

  /// Set service result message
  void setServiceResultMessage(String message) {
    emit(state.copyWith(serviceMessage: message));
  }
}
