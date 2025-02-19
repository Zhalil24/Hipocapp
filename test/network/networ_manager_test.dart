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

  test('Get users items from api', () async {
    final resp = await manager.send<User, List<User>>(
      ProductServicePath.post.value,
      parseModel: User(),
      method: RequestType.GET,
    );

    expect(resp.data, isNotNull);
  });

  test('Get users items from api with error', () async {
    manager.listenErrorState(
      onErrorStatus: (value) {
        if (value == HttpStatus.unauthorized) {}
        expect(value, isNotNull);
      },
    );
    final resp = await manager.send<User, List<User>>(
      ProductServicePath.post.value,
      parseModel: User(),
      method: RequestType.GET,
    );

    expect(resp.data, isNotNull);
  });
}
