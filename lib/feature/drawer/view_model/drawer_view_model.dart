import 'package:core/core.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/feature/drawer/view_model/state/drawer_view_state.dart';
import 'package:hipocapp/product/service/interface/entry_operation.dart';
import 'package:hipocapp/product/service/interface/header_operation.dart';
import 'package:hipocapp/product/service/interface/title_operation.dart';
import 'package:hipocapp/product/state/base/base_cuibt.dart';

import '../../../product/cache/model/user_cache_model.dart';

/// Manage your home view business login-c
final class DrawerViewModel extends BaseCubit<DrawerViewState> {
  /// [HeaderOperation] service
  DrawerViewModel(
      {required HeaderOperation headerOperation,
      required TitleOperation titleOperation,
      required EntryOperation enryOperation,
      required HiveCacheOperation<UserCacheModel> userCacheOperation})
      : _headerOperation = headerOperation,
        _titleOperation = titleOperation,
        _entryOperation = enryOperation,
        _userCacheOperation = userCacheOperation,
        super(DrawerViewState(
          isLoading: false,
          headers: HeaderModel(),
          titles: [],
          isSubItemSelected: false,
        ));
  late final HeaderOperation _headerOperation;
  late final TitleOperation _titleOperation;
  late final EntryOperation _entryOperation;
  late final HiveCacheOperation<UserCacheModel> _userCacheOperation;

  /// Change loading state
  void changeLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  Future<void> getHeaderId(String name) async {
    changeLoading();
    var response = await _headerOperation.getHeaderIdByHeaderName(name);
    emit(state.copyWith(isSubItemSelected: true));
    emit(state.copyWith(headers: response));
    await getTitles(response?.id);
    changeLoading();
  }

  Future<void> getTitles(int? id) async {
    changeLoading();
    if (id == null) return;
    var response = await _titleOperation.getAllTitles(id);
    emit(state.copyWith(titles: response));
    changeLoading();
  }

  Future<void> createEntry(String title, String desc) async {
    changeLoading();
    final entryModel = EntryModel(
      headerId: state.headers.id,
      titleName: title,
      description: desc,
      isEntry: false,
      userId: _getUserId(),
    );

    await _entryOperation.createEntry(entryModel);
    await getTitles(state.headers.id);
    changeLoading();
  }

  int _getUserId() {
    final cachedUser = _userCacheOperation.get('user_token');
    int userId = cachedUser!.userId;
    return userId;
  }
}
