import 'package:gen/gen.dart';
import 'package:hipocapp/product/service/interface/user_operation.dart';
import 'package:hipocapp/product/service/manager/product_service_path.dart';
import 'package:vexana/vexana.dart';

/// Get last entries service
final class UserService extends UserOperation {
  UserService(INetworkManager<EmptyModel> networkManager) : _networkManager = networkManager;

  final INetworkManager<EmptyModel> _networkManager;
  @override
  Future<List<ProfileModel>?> getAllUsers() async {
    final response = await _networkManager.send<ProfileModel, List<ProfileModel>>(
      ProductServicePath.allUser.value,
      parseModel: ProfileModel(),
      method: RequestType.GET,
    );

    return response.data;
  }

  Future<ProfileResponseModel?> getUserById(int userId) async {
    final url = '${ProductServicePath.getByUserId.value}?userId=$userId';
    final response = await _networkManager.send<ProfileResponseModel, ProfileResponseModel>(
      url,
      parseModel: ProfileResponseModel(),
      method: RequestType.GET,
    );

    return response.data;
  }
}
