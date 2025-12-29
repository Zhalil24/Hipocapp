import 'package:gen/gen.dart';

abstract class GroupListOperation {
  Future<List<GroupListModel>?> getGroupList();
  Future<GroupRequestResponseModel> sendToRequestGroup(GroupRequestModel groupRequestModel);
}
