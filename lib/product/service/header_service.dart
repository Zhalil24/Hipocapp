import 'package:gen/gen.dart';
import 'package:hipocapp/product/service/interface/header_operation.dart';
import 'package:hipocapp/product/service/manager/product_service_path.dart';
import 'package:vexana/vexana.dart';

/// Get header service
final class HeaderService extends HeaderOperation {
  HeaderService(INetworkManager<EmptyModel> networkManager) : _networkManager = networkManager;

  final INetworkManager<EmptyModel> _networkManager;
  @override
  Future<List<HeaderModel>?> getHeaderIdByHeaderName(String name) async {
    final response = await _networkManager.send<HeaderResponseModel, HeaderResponseModel>(
      ProductServicePath.lastEntries.value,
      parseModel: HeaderResponseModel(),
      method: RequestType.GET,
      queryParameters: {
        'name': name,
      },
    );
    return response.data?.headers ?? [];
  }
}
