import 'package:hipocapp/feature/drawer/view_model/state/drawer_view_state.dart';
import 'package:hipocapp/product/service/interface/entry_operation.dart';
import 'package:hipocapp/product/state/base/base_cuibt.dart';

/// Manage your home view business login-c
final class DrawerViewModel extends BaseCubit<DrawerViewState> {
  /// [LastEntryOperation] service
  DrawerViewModel({
    required RandomEntryOperation randomEntryOperation,
  }) : super(DrawerViewState(isLoading: false));

  /// Change loading state
  void changeLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }
}
