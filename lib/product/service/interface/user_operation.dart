import 'package:gen/gen.dart';

abstract class UserOperation {
  Future<List<ProfileModel>?> getAllUsers();
  Future<ProfileResponseModel?> getUserById(int userId);
}
