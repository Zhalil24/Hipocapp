import 'dart:io';

import 'package:gen/gen.dart';
import 'package:my_architecture_template/product/init/config/app_environment.dart';
import 'package:my_architecture_template/product/service/manager/product_network_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_architecture_template/product/service/manager/product_service_path.dart';
import 'package:vexana/vexana.dart';

void main() {
  late final ProductNetworkManager manager;

  setUp(() {
    AppEnvironment.general();
    manager = ProductNetworkManager.base();
  });

  test('Post User Login', () async {
    final loginModel = UserLoginModel(
      userName: 'hipocapp',
      password: 'A8717101a',
    );

    final networkResult = await manager.sendRequest<BaseResponseModel, dynamic>(
      ProductServicePath.login.value,
      parseModel: BaseResponseModel(),
      method: RequestType.POST,
      data: loginModel.toJson(),
    );

    expect(networkResult, isNotNull);
    expect(networkResult.isSuccess, isTrue);
  });

  test('Post login user from api with error', () async {
    manager.listenErrorState(
      onErrorStatus: (value) {
        if (value == HttpStatus.unauthorized) {}
        expect(value, isNotNull);
      },
    );
    final resp = await manager.send<UserLoginModel, User>(
      ProductServicePath.post.value,
      parseModel: UserLoginModel(),
      method: RequestType.POST,
    );

    expect(resp.data, isNotNull);
  });
}
