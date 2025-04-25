import 'package:flutter/widgets.dart';
import 'package:hipocapp/product/service/manager/index.dart';
import 'package:hipocapp/product/state/container/product_satate_items.dart';
import 'package:hipocapp/product/state/view_model/product_view_model.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  ProductNetworkManager get productNetworkManager => ProductStateItems.productNetworkManager;

  ProductViewModel get productViewModel => ProductStateItems.productViewModel;
}
