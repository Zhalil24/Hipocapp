import 'package:gen/gen.dart';
import 'package:hipocapp/feature/group_list/view_model/state/group_list_view_state.dart';
import 'package:hipocapp/product/service/interface/group_list_operation.dart';
import 'package:hipocapp/product/state/base/base_cuibt.dart';

final class GroupListViewModel extends BaseCubit<GroupListViewState> {
  /// [LastEntryOperation] service
  GroupListViewModel({
    required GroupListOperation groupListOperation,
  })  : _groupListOperation = groupListOperation,
        super(GroupListViewState(
          isLoading: false,
          groupListModel: [],
        ));
  late final GroupListOperation _groupListOperation;

  /// Change loading state
  void changeLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  /// Fetches the list of groups from the server and updates the state with the
  /// fetched groups. The method shows a loading indicator while fetching the data.
  ///
  /// The method will emit a new state with the updated group list once the data
  /// is fetched from the server.
  Future<void> getGroupList() async {
    changeLoading();
    final resp = await _groupListOperation.getGroupList();
    emit(state.copyWith(groupListModel: resp));
    changeLoading();
  }

  /// Sends a group request to the server for the given group and user IDs.
  ///
  /// The method will show a loading indicator while sending the request, and
  /// will not emit any new states after the request is sent.
  ///
  /// [groupId] is the ID of the group to which the request is being sent.
  /// [userId] is the ID of the user sending the request.
  ///
  Future<GroupRequestResponseModel> sendGroupRequest(int groupId, int userId) async {
    final groupRequestModel = GroupRequestModel(
      groupId: groupId,
      userId: userId,
      requestedOn: DateTime.now().toIso8601String(),
      status: 1,
    );
    final resp = await _groupListOperation.sendToRequestGroup(groupRequestModel);
    return resp;
  }
}
