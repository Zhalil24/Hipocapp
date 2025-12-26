import 'package:core/src/cache/core/cache_model.dart';

abstract class CacheOperation<T extends CacheModel> {
  const CacheOperation();
  Future<void> add(T item);
  Future<void> addAll(List<T> items);
  Future<void> remove(String id);
  Future<void> clear();

  Future<List<T>> getAll();
  Future<T?> get(String id);
}
