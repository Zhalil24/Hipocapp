import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:hipocapp/product/cache/product_cache.dart';
import 'package:hipocapp/product/hub/signalr_service.dart';
import 'package:hipocapp/product/service/manager/product_network_manager.dart';
import 'package:hipocapp/product/state/view_model/product_view_model.dart';

/// Prodcut container for dependency injection
final class ProductStateContainer {
  const ProductStateContainer._();
  static final _getIt = GetIt.I;

  /// Product Core Required Items
  static void setup() {
    _getIt
      ..registerSingleton(ProductCache(cacheManager: SharedCacheManager()))
      ..registerSingleton<ProductNetworkManager>(ProductNetworkManager.base())
      ..registerLazySingleton<SignalRService>(SignalRService.new)
      ..registerLazySingleton<ProductViewModel>(
        () => ProductViewModel(
          themeCache: _getIt<ProductCache>().themeCacheOperation,
          userCache: _getIt<ProductCache>().userCacheOperation,
        ),
      );
  }

  static T read<T extends Object>() => _getIt<T>();
}
