import 'package:flutter/widgets.dart';
import 'package:my_architecture_template/product/service/manager/index.dart';
import 'package:my_architecture_template/product/state/container/product_satate_items.dart';
import 'package:my_architecture_template/product/state/view_model/product_view_model.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  ProductNetworkManager get productNetworkManager => ProductStateItems.productNetworkManager;

  ProductViewModel get productViewModel => ProductStateItems.productViewModel;
}
