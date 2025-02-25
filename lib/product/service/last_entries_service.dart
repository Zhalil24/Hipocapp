import 'package:gen/gen.dart';
import 'package:my_architecture_template/product/service/interface/entry_operation.dart';
import 'package:my_architecture_template/product/service/manager/product_service_path.dart';
import 'package:vexana/vexana.dart';

/// Get last entries service
final class LastEntriesService extends EntryOperation {
  LastEntriesService(INetworkManager<EmptyModel> networkManager) : _networkManager = networkManager;

  final INetworkManager<EmptyModel> _networkManager;
  @override
  Future<List<LastEntriesModel>?> getLastEntries() async {
    final response = await _networkManager.send<LastEntiresResponseModel, LastEntiresResponseModel>(
      ProductServicePath.lastEntries.value,
      parseModel: LastEntiresResponseModel(),
      method: RequestType.GET,
    );

    return response.data?.lastEntries ?? [];
  }
}
