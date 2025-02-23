import 'package:gen/gen.dart';
import 'package:my_architecture_template/product/service/interface/authentication_operation.dart';
import 'package:my_architecture_template/product/service/manager/index.dart';
import 'package:vexana/vexana.dart';

final class LoginService extends AuthenticationOperation {
  LoginService(INetworkManager<EmptyModel> networkManager) : _networkManager = networkManager;

  final INetworkManager<EmptyModel> _networkManager;

  @override
  Future<User?> userLogin({required UserLoginModel userLoginModel}) async {
    final response = await _networkManager.send<UserResponseModel, dynamic>(
      ProductServicePath.login.value,
      parseModel: UserResponseModel(),
      method: RequestType.POST,
      data: userLoginModel.toJson(),
    );

    if (response.data != null) {
      final userResponse = response.data as UserResponseModel;
      return userResponse.user;
    } else {
      return null;
    }
  }
}
