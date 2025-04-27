import 'package:hipocapp/feature/entry_list/view_model/state/entry_list_view_state.dart';
import 'package:hipocapp/product/service/interface/entry_operation.dart';
import 'package:hipocapp/product/state/base/base_cuibt.dart';

/// Manage your home view business login-c
final class EntryListViewModel extends BaseCubit<EntryListViewState> {
  /// [LastEntryOperation] service
  EntryListViewModel({
    required EntryListOperation entryListOperation,
  })  : _entryListOperation = entryListOperation,
        super(EntryListViewState(isLoading: false, entryListModel: []));
  late final EntryListOperation _entryListOperation;

  /// Change loading state
  void changeLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  /// Get random entries
  Future<void> getEntryList(String name) async {
    changeLoading();
    final resp = await _entryListOperation.getEntryList(name);
    emit(state.copyWith(entryListModel: resp));
    changeLoading();
  }
}
