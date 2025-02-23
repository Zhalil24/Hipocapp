import 'package:gen/gen.dart';

abstract class AuthenticationOperation {
  Future<User?> userLogin({required UserLoginModel userLoginModel});
}
