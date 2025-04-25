import 'package:gen/gen.dart';
import 'package:hipocapp/product/init/config/app_environment.dart';
import 'package:hipocapp/product/service/manager/product_network_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hipocapp/product/service/manager/product_service_path.dart';
import 'package:vexana/vexana.dart';

void main() {
  ProductNetworkManager? manager = ProductNetworkManager.base();

  setUp(() {
    AppEnvironment.general();
    manager = ProductNetworkManager.base();
  });

  test('Post User Login', () async {
    final loginModel = UserLoginModel(
      userName: '',
      password: '',
    );

    final networkResult = await manager!.sendRequest<UserResponseModel, dynamic>(
      ProductServicePath.login.value,
      parseModel: UserResponseModel(),
      method: RequestType.POST,
      data: loginModel.toJson(),
    );

    expect(networkResult, isNotNull);
    expect(networkResult.isSuccess, isTrue);
  });

  test('Get Last Entries', () async {
    final response = await manager!.send<LastEntiresResponseModel, dynamic>(
      ProductServicePath.lastEntries.value,
      parseModel: LastEntiresResponseModel(),
      method: RequestType.GET,
    );

    expect(response.data, isNotNull);
  });
}
