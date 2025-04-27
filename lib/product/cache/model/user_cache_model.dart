import 'package:core/core.dart';
import 'package:kartal/kartal.dart';

final class UserCacheModel with CacheModel {
  UserCacheModel({
    required this.token,
    required this.userId,
  });

  UserCacheModel.empty()
      : token = '',
        userId = 0;

  final String token;
  final int userId;

  @override
  UserCacheModel fromDynamicJson(dynamic json) {
    final jsonMap = json as Map<String, dynamic>?;
    if (jsonMap == null || !jsonMap.containsKey('token') || !jsonMap.containsKey('userId')) {
      CustomLogger.showError<UserCacheModel>(
        'Json cannot be null or missing token or userId field',
      );
      return this;
    }
    return copyWith(
      token: jsonMap['token'] as String,
      userId: jsonMap['userId'] as int,
    );
  }

  @override
  String get id => 'user_token';

  @override
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'userId': userId,
    };
  }

  UserCacheModel copyWith({
    String? token,
    int? userId,
  }) {
    return UserCacheModel(
      token: token ?? this.token,
      userId: userId ?? this.userId,
    );
  }
}
