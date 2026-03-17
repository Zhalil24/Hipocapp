import 'package:gen/gen.dart';
import 'package:hipocapp/feature/drawer/view_model/state/drawer_view_state.dart';
import 'package:hipocapp/product/service/interface/entry_operation.dart';
import 'package:hipocapp/product/service/interface/header_operation.dart';
import 'package:hipocapp/product/service/interface/title_operation.dart';
import 'package:hipocapp/product/state/base/base_cuibt.dart';

/// Manage your home view business login-c
final class DrawerViewModel extends BaseCubit<DrawerViewState> {
  /// [HeaderOperation] service
  DrawerViewModel({
    required HeaderOperation headerOperation,
    required TitleOperation titleOperation,
    required EntryOperation enryOperation,
  })  : _headerOperation = headerOperation,
        _titleOperation = titleOperation,
        _entryOperation = enryOperation,
        super(DrawerViewState(
          isLoading: false,
          headers: HeaderModel(),
          titles: [],
          isSubItemSelected: false,
        ));
  late final HeaderOperation _headerOperation;
  late final TitleOperation _titleOperation;
  late final EntryOperation _entryOperation;

  void _setLoading(bool value) {
    emit(state.copyWith(isLoading: value));
  }

  /// Clear service message
  void clearServiceMessage() {
    emit(state.copyWith(serviceResponseMessage: null));
  }

  /// Set service response
  void setServiceRespnonse(String? message) {
    emit(state.copyWith(serviceResponseMessage: message));
  }

  Future<void> getHeaderId(String name) async {
    _setLoading(true);
    final response = await _headerOperation.getHeaderIdByHeaderName(name);
    emit(
      state.copyWith(
        isSubItemSelected: response != null,
        headers: response ?? HeaderModel(),
      ),
    );
    await _loadTitles(response?.id);
    _setLoading(false);
  }

  Future<void> getTitles(int? id) async {
    _setLoading(true);
    await _loadTitles(id);
    _setLoading(false);
  }

  Future<void> _loadTitles(int? id) async {
    if (id == null) {
      emit(state.copyWith(titles: []));
      return;
    }
    final response = await _titleOperation.getAllTitles(id);
    emit(state.copyWith(titles: response));
  }

  Future<void> createEntry(String title, String desc, int userId) async {
    _setLoading(true);
    final entryModel = EntryModel(
      headerId: state.headers.id,
      titleName: title,
      description: desc,
      isEntry: false,
      userId: userId,
    );

    final resp = await _entryOperation.createEntry(entryModel);
    setServiceRespnonse(resp?.message);
    await _loadTitles(state.headers.id);
    _setLoading(false);
  }
}
