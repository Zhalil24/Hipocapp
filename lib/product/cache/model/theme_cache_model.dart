import 'package:core/core.dart';
import 'package:flutter/material.dart';

final class ThemeCacheModel with CacheModel {
  const ThemeCacheModel({
    required this.themeIndex,
  });

  const ThemeCacheModel.empty() : themeIndex = 0;

  final int themeIndex;

  @override
  String get id => 'theme_cache';

  @override
  ThemeCacheModel fromDynamicJson(dynamic json) {
    final jsonMap = json as Map<String, dynamic>?;
    if (jsonMap == null || !jsonMap.containsKey('themeIndex')) {
      return const ThemeCacheModel.empty();
    }
    final idx = jsonMap['themeIndex'] as int;
    return ThemeCacheModel(themeIndex: idx);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'themeIndex': themeIndex,
    };
  }

  ThemeCacheModel copyWith({int? themeIndex}) {
    return ThemeCacheModel(
      themeIndex: themeIndex ?? this.themeIndex,
    );
  }

  ThemeMode get themeMode => themeIndex == 1 ? ThemeMode.dark : ThemeMode.light;
}
