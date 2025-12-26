import 'package:gen/gen.dart';
import 'package:hipocapp/feature/entry_list/view_model/state/entry_list_view_state.dart';
import 'package:hipocapp/product/service/interface/entry_operation.dart';
import 'package:hipocapp/product/state/base/base_cuibt.dart';

/// Manage your home view business login-c
final class EntryListViewModel extends BaseCubit<EntryListViewState> {
  /// [LastEntryOperation] service
  EntryListViewModel({
    required EntryListOperation entryListOperation,
    required EntryOperation entryOperation,
  })  : _entryListOperation = entryListOperation,
        _entryOperation = entryOperation,
        super(EntryListViewState(
          isLoading: false,
          entryListModel: [],
        ));
  late final EntryListOperation _entryListOperation;
  late final EntryOperation _entryOperation;

  /// Change loading state
  void changeLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  /// Clear service message
  void clearServiceMessage() {
    emit(state.copyWith(serviceResponseMessage: null));
  }

  /// Set service response
  void setServiceRespnonse(String? message) {
    emit(state.copyWith(serviceResponseMessage: message));
  }

  /// Get random entries
  Future<void> getEntryList(String name) async {
    changeLoading();
    final resp = await _entryListOperation.getEntryList(name);
    emit(state.copyWith(entryListModel: resp));
    changeLoading();
  }

  Future<void> createEntry(String title, String desc, int headerId, int userId) async {
    final entryModel = EntryModel(
      headerId: headerId,
      titleName: title,
      description: desc,
      isEntry: true,
      userId: userId,
    );
    var resp = await _entryOperation.createEntry(entryModel);
    setServiceRespnonse(resp?.message ?? '');
    await getEntryList(title);
  }
}
