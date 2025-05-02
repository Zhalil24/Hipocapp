import 'package:gen/gen.dart';

abstract class ProfileOperation {
  Future<ProfileModel?> getProfile(int id);
  Future<ProfileModel?> updateProfile(ProfileUpdateModel model);
  Future<String?> changePassword(ChangePasswordModel model);
}
