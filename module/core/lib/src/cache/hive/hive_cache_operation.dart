import 'package:core/core.dart';
import 'package:hive/hive.dart';

final class HiveCacheOperation<T extends CacheModel> extends CacheOperation<T> {
  /// Prototip olarak kullanacağın boş model örneği
  final T emptyModel;
  late final Box<Map<String, dynamic>> _box;

  HiveCacheOperation({required this.emptyModel}) {
    // boxName olarak emptyModel.id kullan
    _box = Hive.box<Map<String, dynamic>>(name: emptyModel.id);
  }

  @override
  void add(T item) {
    _box.put(item.id, item.toJson());
  }

  @override
  void addAll(List<T> items) {
    final map = <String, Map<String, dynamic>>{
      for (var item in items) item.id: item.toJson(),
    };
    _box.putAll(map);
  }

  @override
  void clear() => _box.clear();

  @override
  T? get(String id) {
    final json = _box.get(id);
    if (json == null) return null;
    // emptyModel üzerinden dönüştür
    return emptyModel.fromDynamicJson(json) as T;
  }

  @override
  List<T> getAll() {
    return _box.keys.map((key) => _box.get(key)).where((json) => json != null).map((json) => emptyModel.fromDynamicJson(json) as T).toList();
  }

  @override
  void remove(String id) => _box.delete(id);
}
