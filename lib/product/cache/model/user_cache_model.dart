import 'package:core/core.dart';
import 'package:kartal/kartal.dart';

final class UserCacheModel with CacheModel {
  UserCacheModel({
    required this.token,
    required this.userId,
    required this.userName,
  });

  UserCacheModel.empty()
      : token = '',
        userId = 0,
        userName = '';

  final String token;
  final int userId;
  final String userName;

  @override
  UserCacheModel fromDynamicJson(dynamic json) {
    final jsonMap = json as Map<String, dynamic>?;
    if (jsonMap == null || !jsonMap.containsKey('token') || !jsonMap.containsKey('userId') || !jsonMap.containsKey('userName')) {
      CustomLogger.showError<UserCacheModel>(
        'Json cannot be null or missing token, userId, or userName field',
      );
      return this;
    }
    return copyWith(
      token: jsonMap['token'] as String,
      userId: jsonMap['userId'] as int,
      userName: jsonMap['userName'] as String,
    );
  }

  @override
  String get id => 'user_token';

  @override
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'userId': userId,
      'userName': userName,
    };
  }

  UserCacheModel copyWith({
    String? token,
    int? userId,
    String? userName,
  }) {
    return UserCacheModel(
      token: token ?? this.token,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
    );
  }
}
