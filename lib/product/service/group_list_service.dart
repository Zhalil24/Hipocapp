import 'package:gen/gen.dart';
import 'package:hipocapp/product/service/interface/group_list_operation.dart';
import 'package:hipocapp/product/service/manager/product_service_path.dart';
import 'package:vexana/vexana.dart';

final class GroupListService extends GroupListOperation {
  GroupListService(INetworkManager<EmptyModel> networkManager) : _networkManager = networkManager;

  final INetworkManager<EmptyModel> _networkManager;
  @override
  Future<List<GroupListModel>?> getGroupList() async {
    final response = await _networkManager.send<GroupListResponseModel, GroupListResponseModel>(
      ProductServicePath.getGroupList.value,
      parseModel: GroupListResponseModel(),
      method: RequestType.GET,
    );

    return response.data?.groupList ?? [];
  }

  @override
  Future<GroupRequestResponseModel> sendToRequestGroup(GroupRequestModel groupRequestModel) async {
    final response = await _networkManager.send<GroupRequestResponseModel, GroupRequestResponseModel>(
      ProductServicePath.requestGroup.value,
      parseModel: GroupRequestResponseModel(),
      method: RequestType.POST,
      data: groupRequestModel.toJson(),
    );

    return response.data!;
  }
}
