import 'package:gen/gen.dart';
import 'package:hipocapp/product/service/interface/entry_operation.dart';
import 'package:hipocapp/product/service/manager/product_service_path.dart';
import 'package:vexana/vexana.dart';

/// Get last entries service
final class EntryListService extends EntryListOperation {
  EntryListService(INetworkManager<EmptyModel> networkManager) : _networkManager = networkManager;

  final INetworkManager<EmptyModel> _networkManager;
  @override
  Future<List<EntryListModel>?> getEntryList(String name) async {
    final response = await _networkManager.send<EntryListResponseModel, EntryListResponseModel>(
      ProductServicePath.entryList.value,
      parseModel: EntryListResponseModel(),
      method: RequestType.GET,
      queryParameters: {'name': name},
    );

    return response.data?.entryListModel ?? [];
  }
}
