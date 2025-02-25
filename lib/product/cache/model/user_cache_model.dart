import 'package:core/core.dart';
import 'package:kartal/kartal.dart';

final class UserCacheModel with CacheModel {
  UserCacheModel({required this.token});
  UserCacheModel.empty() : token = '';

  final String token;

  @override
  UserCacheModel fromDynamicJson(dynamic json) {
    final jsonMap = json as Map<String, dynamic>?;
    if (jsonMap == null || !jsonMap.containsKey('token')) {
      CustomLogger.showError<UserCacheModel>('Json cannot be null or missing token field');
      return this;
    }
    return copyWith(
      token: jsonMap['token'] as String,
    );
  }

  @override
  String get id => token;
  @override
  Map<String, dynamic> toJson() {
    return {'token': token};
  }

  UserCacheModel copyWith({
    String? token,
  }) {
    return UserCacheModel(token: token ?? this.token);
  }
}
