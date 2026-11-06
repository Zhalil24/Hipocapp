import 'package:gen/gen.dart';
import 'package:hipocapp/product/service/interface/follow_operation.dart';
import 'package:hipocapp/product/service/manager/product_service_path.dart';
import 'package:vexana/vexana.dart';

final class FollowService extends FollowOperation {
  FollowService(INetworkManager<EmptyModel> networkManager) : _networkManager = networkManager;

  final INetworkManager<EmptyModel> _networkManager;

  @override
  Future<FollowResponseModel?> follow(FollowModel model) async {
    final payload = {
      'followerUserId': model.followerUserId,
      'followingUserId': model.followingUserId,
    };

    final response = await _networkManager.send<FollowResponseModel, FollowResponseModel>(
      ProductServicePath.follow.value,
      parseModel: FollowResponseModel(),
      method: RequestType.POST,
      data: payload,
    );

    return response.data;
  }

  @override
  Future<FollowResponseModel?> unfollow({
    required int followerUserId,
    required int followingUserId,
  }) async {
    final queryParameters = {
      'followerUserId': followerUserId,
      'followingUserId': followingUserId,
    };

    final response = await _networkManager.send<FollowResponseModel, FollowResponseModel>(
      ProductServicePath.unfollow.value,
      parseModel: FollowResponseModel(),
      method: RequestType.DELETE,
      queryParameters: queryParameters,
    );

    return response.data;
  }

  @override
  Future<FollowUserListResponseModel?> getFollowers(int userId) async {
    final queryParameters = {'userId': userId};

    final response = await _networkManager.send<FollowUserListResponseModel, FollowUserListResponseModel>(
      ProductServicePath.getFollowers.value,
      parseModel: FollowUserListResponseModel(),
      method: RequestType.GET,
      queryParameters: queryParameters,
    );

    return response.data;
  }

  @override
  Future<FollowUserListResponseModel?> getFollowing(int userId) async {
    final queryParameters = {'userId': userId};

    final response = await _networkManager.send<FollowUserListResponseModel, FollowUserListResponseModel>(
      ProductServicePath.getFollowing.value,
      parseModel: FollowUserListResponseModel(),
      method: RequestType.GET,
      queryParameters: queryParameters,
    );

    return response.data;
  }

  @override
  Future<FollowCountResponseModel?> getCounts(int userId) async {
    final queryParameters = {'userId': userId};

    final response = await _networkManager.send<FollowCountResponseModel, FollowCountResponseModel>(
      ProductServicePath.getFollowCounts.value,
      parseModel: FollowCountResponseModel(),
      method: RequestType.GET,
      queryParameters: queryParameters,
    );

    return response.data;
  }

  @override
  Future<FollowStatusResponseModel?> getStatus({
    required int followerUserId,
    required int followingUserId,
  }) async {
    final queryParameters = {
      'followerUserId': followerUserId,
      'followingUserId': followingUserId,
    };

    final response = await _networkManager.send<FollowStatusResponseModel, FollowStatusResponseModel>(
      ProductServicePath.getFollowStatus.value,
      parseModel: FollowStatusResponseModel(),
      method: RequestType.GET,
      queryParameters: queryParameters,
    );

    return response.data;
  }
}
