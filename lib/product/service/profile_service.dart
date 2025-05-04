import 'package:gen/gen.dart';
import 'package:hipocapp/product/service/interface/profile_operation.dart';
import 'package:hipocapp/product/service/manager/index.dart';
import 'package:vexana/vexana.dart';

final class ProfileService extends ProfileOperation {
  ProfileService(INetworkManager<EmptyModel> networkManager) : _networkManager = networkManager;

  final INetworkManager<EmptyModel> _networkManager;
  @override
  Future<ProfileResponseModel?> getProfile(int id) async {
    final response = await _networkManager.send<ProfileResponseModel, ProfileResponseModel>(
      ProductServicePath.profile.value,
      parseModel: ProfileResponseModel(),
      method: RequestType.GET,
      queryParameters: {
        'id': id,
      },
    );
    return response.data;
  }

  @override
  Future<ProfileModel?> updateProfile(ProfileUpdateModel model) async {
    final formData = FormData.fromMap({
      'Id': model.id.toString(),
      'Name': model.name,
      'Surname': model.surname,
      'Username': model.username,
      'Email': model.email,
      'Password': model.password,
      'PasswordRe': model.passwordRe,
      if (model.photo != null)
        'Photo': await MultipartFile.fromFile(
          model.photo!.path,
          filename: model.photo!.path.split('/').last,
        ),
    });

    final response = await _networkManager.uploadFile<Map<String, dynamic>>(
      ProductServicePath.updateProfile.value,
      formData,
    );

    final json = response.data;
    if (json == null) return null;
    return ProfileModel.fromJson(json);
  }

  @override
  Future<String?> changePassword(ChangePasswordModel model) async {
    final response = await _networkManager.send<ProfileResponseModel, ProfileResponseModel>(
      ProductServicePath.changePassword.value,
      parseModel: ProfileResponseModel(),
      method: RequestType.POST,
      data: model,
    );
    return response.data?.message;
  }
}
