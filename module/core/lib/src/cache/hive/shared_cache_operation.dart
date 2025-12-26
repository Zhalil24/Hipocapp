import 'dart:convert';
import 'package:core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class SharedCacheOperation<T extends CacheModel> extends CacheOperation<T> {
  final T emptyModel;

  SharedCacheOperation({required this.emptyModel});

  Future<SharedPreferences> get _prefs async => await SharedPreferences.getInstance();

  @override
  Future<void> add(T item) async {
    final prefs = await _prefs;
    await prefs.setString(item.id, jsonEncode(item.toJson()));
  }

  @override
  Future<void> addAll(List<T> items) async {
    final prefs = await _prefs;
    for (final item in items) {
      await prefs.setString(item.id, jsonEncode(item.toJson()));
    }
  }

  @override
  Future<void> remove(String id) async {
    final prefs = await _prefs;
    await prefs.remove(id);
  }

  @override
  Future<void> clear() async {
    final prefs = await _prefs;
    await prefs.clear();
  }

  @override
  Future<T?> get(String id) async {
    final prefs = await _prefs;
    final jsonString = prefs.getString(id);
    if (jsonString == null) return null;
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
    return emptyModel.fromDynamicJson(jsonMap) as T;
  }

  @override
  Future<List<T>> getAll() async {
    final prefs = await _prefs;
    final List<T> list = [];
    for (final key in prefs.getKeys()) {
      final jsonString = prefs.getString(key);
      if (jsonString != null) {
        final Map<String, dynamic> jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
        list.add(emptyModel.fromDynamicJson(jsonMap) as T);
      }
    }
    return list;
  }
}
