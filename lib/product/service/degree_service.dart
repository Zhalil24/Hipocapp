import 'package:gen/gen.dart';
import 'package:hipocapp/product/service/interface/degree_operation.dart';
import 'package:hipocapp/product/service/manager/product_service_path.dart';
import 'package:vexana/vexana.dart';

/// Get header service
final class DegreeService extends DegreeOperation {
  DegreeService(INetworkManager<EmptyModel> networkManager) : _networkManager = networkManager;

  final INetworkManager<EmptyModel> _networkManager;
  @override
  Future<DegreeResponseModel?> getDegree() async {
    {
      final response = await _networkManager.send<DegreeResponseModel, DegreeResponseModel>(
        ProductServicePath.getdegree.value,
        parseModel: DegreeResponseModel(),
        method: RequestType.GET,
      );
      return response.data;
    }
  }
}
