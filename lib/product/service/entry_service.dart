import 'package:gen/gen.dart';
import 'package:hipocapp/product/service/interface/entry_operation.dart';
import 'package:hipocapp/product/service/manager/product_service_path.dart';
import 'package:vexana/vexana.dart';

/// Get header service
final class EntryService extends EntryOperation {
  EntryService(INetworkManager<EmptyModel> networkManager) : _networkManager = networkManager;

  final INetworkManager<EmptyModel> _networkManager;
  @override
  Future<EntryModel?> createEntry(EntryModel entryModel) async {
    final formData = FormData.fromMap({
      'titleName': entryModel.titleName,
      'description': entryModel.description,
      'headerId': entryModel.headerId.toString(),
      'isEntry': entryModel.isEntry.toString(),
      'userId': entryModel.userId.toString(),
    });
    final response = await _networkManager.uploadFile<Map<String, dynamic>>(
      ProductServicePath.createEntry.value,
      formData,
    );
    final json = response.data;
    if (json == null) return null;
    return EntryModel.fromJson(json);
  }

  @override
  Future<EntryModel?> deleteEntry(int id) async {
    final response = await _networkManager.send<EntryModel, EntryModel>(
      ProductServicePath.deleteEntry.value,
      parseModel: EntryModel(),
      method: RequestType.DELETE,
      queryParameters: {'id': id},
    );

    return response.data;
  }
}
