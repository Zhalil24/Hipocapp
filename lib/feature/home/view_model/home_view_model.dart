import 'package:my_architecture_template/feature/home/view_model/state/home_view_state.dart';
import 'package:my_architecture_template/product/service/interface/entry_operation.dart';
import 'package:my_architecture_template/product/state/base/base_cuibt.dart';

/// Manage your home view business login-c
final class HomeViewModel extends BaseCubit<HomeViewState> {
  /// [LastEntryOperation] service
  HomeViewModel({
    required LastEntryOperation lastEntriesOperation,
    required RandomEntryOperation randomEntryOperation,
  })  : _lastEntriesOperation = lastEntriesOperation,
        _randomEntryOperation = randomEntryOperation,
        super(HomeViewState(isLoading: false));
  late final LastEntryOperation _lastEntriesOperation;
  late final RandomEntryOperation _randomEntryOperation;

  /// Change loading state
  void changeLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  void changeEntries(bool isChange) {
    emit(state.copyWith(
      isLastEntries: isChange,
      isRandomEntries: !isChange,
    ));

    if (isChange) {
      getLastEntries();
    } else {
      getRandomEntries();
    }
  }

  /// Get last entries
  Future<void> getLastEntries() async {
    changeLoading();
    final resp = await _lastEntriesOperation.getLastEntries();
    emit(state.copyWith(lastEntries: resp));
    changeLoading();
  }

  /// Get random entries
  Future<void> getRandomEntries() async {
    changeLoading();
    final resp = await _randomEntryOperation.getRandomEntries();
    emit(state.copyWith(randomEntries: resp));
    changeLoading();
  }
}
