import 'package:gen/gen.dart';

abstract class AuthenticationOperation {
  Future<UserResponseModel?> userLogin({required UserLoginModel userLoginModel});
  Future<ProfileResponseModel?> forgotPasswordService(String email);
}
