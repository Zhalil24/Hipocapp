import 'package:gen/gen.dart';
import 'package:hipocapp/product/service/interface/authentication_operation.dart';
import 'package:hipocapp/product/service/manager/index.dart';
import 'package:vexana/vexana.dart';

final class LoginService extends AuthenticationOperation {
  LoginService(INetworkManager<EmptyModel> networkManager) : _networkManager = networkManager;

  final INetworkManager<EmptyModel> _networkManager;

  @override
  Future<UserResponseModel?> userLogin({required UserLoginModel userLoginModel}) async {
    final response = await _networkManager.send<UserResponseModel, UserResponseModel>(
      ProductServicePath.login.value,
      parseModel: UserResponseModel(),
      method: RequestType.POST,
      data: userLoginModel.toJson(),
    );

    if (response.data != null) {
      final userResponse = response.data as UserResponseModel;
      return userResponse;
    } else {
      return null;
    }
  }

  // @override
  // Future<UserResponseModel?> forgotPasswordService(String email) async {
  //   final response = await _networkManager.send<UserResponseModel, UserResponseModel>(ProductServicePath.forgotPassword.value,
  //       parseModel: UserResponseModel(),
  //       method: RequestType.POST,
  //       queryParameters: {
  //         'email': email,
  //       });

  //   return response.data;
  // }

  @override
  Future<ProfileResponseModel?> forgotPasswordService(String email) async {
    try {
      final response = await _networkManager.send<ProfileResponseModel, ProfileResponseModel>(ProductServicePath.forgotPassword.value,
          parseModel: ProfileResponseModel(),
          method: RequestType.POST,
          queryParameters: {
            'email': email,
          });

      print("URL: ${ProductServicePath.forgotPassword.value}");
      print("Error: ${response.error}");
      print("Data: ${response.data}");

      if (response.data != null) {
        final userResponse = response.data as ProfileResponseModel;
        return userResponse;
      } else {
        return null;
      }
    } catch (e, stack) {
      print("❌ HATA: $e");
      print("🧱 STACK: $stack");
      return null;
    }
  }
}
