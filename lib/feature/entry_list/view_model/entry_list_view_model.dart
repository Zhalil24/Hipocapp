import 'package:core/core.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/feature/entry_list/view_model/state/entry_list_view_state.dart';
import 'package:hipocapp/product/cache/model/user_cache_model.dart';
import 'package:hipocapp/product/service/interface/entry_operation.dart';
import 'package:hipocapp/product/state/base/base_cuibt.dart';

/// Manage your home view business login-c
final class EntryListViewModel extends BaseCubit<EntryListViewState> {
  /// [LastEntryOperation] service
  EntryListViewModel({
    required EntryListOperation entryListOperation,
    required HiveCacheOperation<UserCacheModel> userCacheOperation,
    required EntryOperation entryOperation,
  })  : _userCacheOperation = userCacheOperation,
        _entryListOperation = entryListOperation,
        _entryOperation = entryOperation,
        super(EntryListViewState(
          isLoading: false,
          entryListModel: [],
        ));
  late final EntryListOperation _entryListOperation;
  late final EntryOperation _entryOperation;
  late final HiveCacheOperation<UserCacheModel> _userCacheOperation;

  /// Change loading state
  void changeLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  /// Saves the service response message.
  void serviceResponseMessageSave(String? message) {
    emit(state.copyWith(serviceResultMessage: message));
  }

  /// Get random entries
  Future<void> getEntryList(String name) async {
    changeLoading();
    final resp = await _entryListOperation.getEntryList(name);
    emit(state.copyWith(entryListModel: resp));
    changeLoading();
  }

  Future<String> createEntry(String title, String desc, int headerId) async {
    final entryModel = EntryModel(
      headerId: headerId,
      titleName: title,
      description: desc,
      isEntry: true,
      userId: _getUserId(),
    );
    var resp = await _entryOperation.createEntry(entryModel);
    serviceResponseMessageSave(resp?.message);
    await getEntryList(title);
    return resp?.message ?? '';
  }

  int _getUserId() {
    final cachedUser = _userCacheOperation.get('user_token');
    int userId = cachedUser!.userId;
    return userId;
  }
}
