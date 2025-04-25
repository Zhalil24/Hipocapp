import 'package:hipocapp/product/cache/product_cache.dart';
import 'package:hipocapp/product/service/manager/index.dart';
import 'package:hipocapp/product/state/container/product_state_container.dart';
import 'package:hipocapp/product/state/view_model/product_view_model.dart';

final class ProductStateItems {
  const ProductStateItems._();
  static ProductNetworkManager get productNetworkManager => ProductStateContainer.read<ProductNetworkManager>();
  static ProductViewModel get productViewModel => ProductStateContainer.read<ProductViewModel>();
  static ProductCache get productCache => ProductStateContainer.read<ProductCache>();
}
