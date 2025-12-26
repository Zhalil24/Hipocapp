import 'package:core/src/cache/core/cache_manager.dart';
import 'package:core/src/cache/core/cache_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class SharedCacheManager<T extends CacheModel> extends CacheManager {
  SharedCacheManager({super.path});

  @override
  Future<void> init({required List<CacheModel> items}) async {
    await SharedPreferences.getInstance();
  }

  @override
  Future<void> remove() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
