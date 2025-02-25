import 'package:my_architecture_template/feature/home/view_model/state/home_view_state.dart';
import 'package:my_architecture_template/product/service/interface/entry_operation.dart';
import 'package:my_architecture_template/product/state/base/base_cuibt.dart';

/// Manage your home view business login-c
final class HomeViewModel extends BaseCubit<HomeViewState> {
  /// [EntryOperation] service
  HomeViewModel({
    required EntryOperation entryOperation,
  })  : _entryOperation = entryOperation,
        super(HomeViewState(isLoading: false));
  late final EntryOperation _entryOperation;

  /// Change loading state
  void changeLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  /// Get last entries
  Future<void> getLastEntries() async {
    changeLoading();
    final resp = await _entryOperation.getLastEntries();
    emit(state.copyWith(lastEntries: resp));
    changeLoading();
  }
}
