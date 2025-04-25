import 'package:gen/gen.dart';
import 'package:hipocapp/product/service/interface/title_operation.dart';
import 'package:hipocapp/product/service/manager/product_service_path.dart';
import 'package:vexana/vexana.dart';

/// Get header service
final class TitleService extends TitleOperation {
  TitleService(INetworkManager<EmptyModel> networkManager) : _networkManager = networkManager;

  final INetworkManager<EmptyModel> _networkManager;
  @override
  Future<List<TitleModel>?> getAllTitles(int id) async {
    final response = await _networkManager.send<TitleResponseModel, TitleResponseModel>(
      ProductServicePath.lastEntries.value,
      parseModel: TitleResponseModel(),
      method: RequestType.GET,
      queryParameters: {
        'id': id,
      },
    );
    return response.data?.titles ?? [];
  }
}
