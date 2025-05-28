import 'package:gen/gen.dart';
import 'package:hipocapp/product/init/config/app_environment.dart';
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

  @override
  Future<ProfileResponseModel?> forgotPasswordService(String email) async {
    final response = await _networkManager.send<ProfileResponseModel, ProfileResponseModel>(ProductServicePath.forgotPassword.value,
        parseModel: ProfileResponseModel(),
        method: RequestType.POST,
        queryParameters: {
          'email': email,
        });

    if (response.data != null) {
      final userResponse = response.data as ProfileResponseModel;
      return userResponse;
    } else {
      return null;
    }
  }

  @override
  // Future<UserRegisterResponseModel?> userRegister(UserRegisterModel model) async {
  //   try {
  //     // Form verilerini oluşturuyoruz
  //     final formData = FormData.fromMap({
  //       'Name': model.name,
  //       'Surname': model.surname,
  //       'Username': model.username,
  //       'DegreeId': model.degreeId,
  //       'ImageURL': model.imageURL,
  //       'Email': model.email,
  //       'IdentityNumber': model.identityNumber,
  //       'IsTermsAccepted': model.isTermsAccepted,
  //       'Password': model.password,
  //       'PasswordRepeat': model.passwordRepeat,
  //       'PhoneNumber': model.phoneNumber,
  //       if (model.image != null)
  //         'Image': await MultipartFile.fromFile(
  //           model.image!.path,
  //           filename: model.image!.path.split('/').last,
  //         ),
  //     });

  //     final response = await _networkManager.uploadFile<Map<String, dynamic>>(
  //       ProductServicePath.userRegister.value,
  //       formData,
  //     );

  //     final json = response.data;
  //     return UserRegisterResponseModel.fromJson(json!);
  //   } catch (e) {
  //     print('Error during user registration: $e');
  //     return null;
  //   }
  // }
  Future<UserRegisterResponseModel?> userRegister(UserRegisterModel model) async {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: AppEnvironmentItems.baseUrl.value,
        validateStatus: (status) => status != null && status < 500,
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      ),
    );

    final formData = FormData.fromMap({
      'Name': model.name,
      'Surname': model.surname,
      'Username': model.username,
      'DegreeId': model.degreeId,
      'ImageURL': model.imageURL,
      'Email': model.email,
      'IdentityNumber': model.identityNumber,
      'IsTermsAccepted': model.isTermsAccepted,
      'Password': model.password,
      'PasswordRepeat': model.passwordRepeat,
      'PhoneNumber': model.phoneNumber,
      if (model.image != null)
        'Image': await MultipartFile.fromFile(
          model.image!.path,
          filename: model.image!.path.split('/').last,
        ),
    });

    final response = await dio.post<Map<String, dynamic>>(
      ProductServicePath.userRegister.value,
      data: formData,
    );

    if (response.data != null) {
      return UserRegisterResponseModel.fromJson(response.data!);
    } else {
      return null;
    }
  }
}
