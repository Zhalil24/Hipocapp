import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:my_architecture_template/product/cache/product_cache.dart';
import 'package:my_architecture_template/product/service/manager/product_network_manager.dart';
import 'package:my_architecture_template/product/state/view_model/product_view_model.dart';

/// Prodcut container for dependency injection
final class ProductStateContainer {
  const ProductStateContainer._();
  static final _getIt = GetIt.I;

  /// Product Core Required Items
  static void setup() {
    _getIt
      ..registerSingleton(ProductCache(cacheManager: HiveCacheManager()))
      ..registerSingleton<ProductNetworkManager>(ProductNetworkManager.base())
      ..registerLazySingleton<ProductViewModel>(ProductViewModel.new);
  }

  static T read<T extends Object>() => _getIt<T>();
}
