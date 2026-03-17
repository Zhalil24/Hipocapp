import 'package:gen/gen.dart';
import 'package:hipocapp/feature/group_list/view_model/state/group_list_view_state.dart';
import 'package:hipocapp/product/service/interface/group_list_operation.dart';
import 'package:hipocapp/product/state/base/base_cuibt.dart';

final class GroupListViewModel extends BaseCubit<GroupListViewState> {
  GroupListViewModel({
    required GroupListOperation groupListOperation,
  })  : _groupListOperation = groupListOperation,
        super(const GroupListViewState(isLoading: false));

  final GroupListOperation _groupListOperation;

  void _setLoading(bool value) {
    if (state.isLoading == value) return;
    emit(state.copyWith(isLoading: value));
  }

  Future<void> getGroupList() async {
    _setLoading(true);
    try {
      final response = await _groupListOperation.getGroupList();
      emit(
        state.copyWith(
          groupListModel: response ?? const <GroupListModel>[],
        ),
      );
    } finally {
      _setLoading(false);
    }
  }

  Future<GroupRequestResponseModel> sendGroupRequest(
    int groupId,
    int userId,
  ) async {
    final groupRequestModel = GroupRequestModel(
      groupId: groupId,
      userId: userId,
      requestedOn: DateTime.now().toIso8601String(),
      status: 1,
    );

    return _groupListOperation.sendToRequestGroup(groupRequestModel);
  }
}
