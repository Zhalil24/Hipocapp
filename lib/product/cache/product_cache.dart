import 'package:core/core.dart';
import 'package:hipocapp/product/cache/model/theme_cache_model.dart';
import 'package:hipocapp/product/cache/model/user_cache_model.dart';

final class ProductCache {
  ProductCache({required CacheManager cacheManager}) : _cacheManager = cacheManager;

  final CacheManager _cacheManager;

  Future<void> init() async {
    await _cacheManager.init(items: [
      UserCacheModel.empty(),
      const ThemeCacheModel.empty(),
    ]);
  }

  late final HiveCacheOperation<UserCacheModel> userCacheOperation = HiveCacheOperation(emptyModel: UserCacheModel.empty());

  late final HiveCacheOperation<ThemeCacheModel> themeCacheOperation = HiveCacheOperation(emptyModel: ThemeCacheModel.empty());
}
