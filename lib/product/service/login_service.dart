import 'package:gen/gen.dart';
import 'package:my_architecture_template/product/service/interface/authentication_operation.dart';
import 'package:my_architecture_template/product/service/manager/index.dart';
import 'package:vexana/vexana.dart';

final class LoginService extends AuthenticationOperation {
  LoginService(INetworkManager<EmptyModel> networkManager) : _networkManager = networkManager;

  final INetworkManager<EmptyModel> _networkManager;

  @override
  Future<User?> userLogin() async {
    final response =
        await _networkManager.send<UserLoginModel, User>(ProductServicePath.login.value, parseModel: UserLoginModel(), method: RequestType.POST);

    return response.data;
  }
}
