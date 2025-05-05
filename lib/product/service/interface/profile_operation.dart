import 'package:gen/gen.dart';

abstract class ProfileOperation {
  Future<ProfileResponseModel?> getProfile(int id);
  Future<UserResponseModel?> updateProfile(ProfileUpdateModel model);
  Future<String?> changePassword(ChangePasswordModel model);
}
