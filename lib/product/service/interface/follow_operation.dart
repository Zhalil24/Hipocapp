import 'package:gen/gen.dart';

abstract class FollowOperation {
  Future<FollowResponseModel?> follow(FollowModel model);
  Future<FollowResponseModel?> unfollow({
    required int followerUserId,
    required int followingUserId,
  });
  Future<FollowUserListResponseModel?> getFollowers(int userId);
  Future<FollowUserListResponseModel?> getFollowing(int userId);
  Future<FollowCountResponseModel?> getCounts(int userId);
  Future<FollowStatusResponseModel?> getStatus({
    required int followerUserId,
    required int followingUserId,
  });
}
