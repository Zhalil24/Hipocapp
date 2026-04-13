import 'package:flutter_test/flutter_test.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/product/service/manager/product_service_path.dart';

void main() {
  group('Follow models', () {
    test('FollowModel serializes request body', () {
      final model = FollowModel(
        followerUserId: 1,
        followingUserId: 2,
      );

      expect(
        model.toJson(),
        {
          'followerUserId': 1,
          'followingUserId': 2,
          'id': null,
          'followDate': null,
        },
      );
    });

    test('FollowResponseModel parses follow response', () {
      final response = FollowResponseModel.fromJson({
        'isSuccess': true,
        'data': {
          'id': 5,
          'followerUserId': 1,
          'followingUserId': 2,
          'followDate': '2026-04-12T21:00:00',
        },
        'message': 'Takip islemi basarili.',
      });

      expect(response.isSuccess, isTrue);
      expect(response.followModel?.id, 5);
      expect(response.followModel?.followerUserId, 1);
      expect(response.followModel?.followingUserId, 2);
      expect(response.followModel?.followDate, DateTime.parse('2026-04-12T21:00:00'));
      expect(response.message, 'Takip islemi basarili.');
    });

    test('FollowUserListResponseModel parses follower list', () {
      final response = FollowUserListResponseModel.fromJson({
        'isSuccess': true,
        'data': [
          {
            'id': 5,
            'followerUserId': 1,
            'followingUserId': 2,
            'followerUserName': 'ibrah',
            'followingUserName': 'doctorx',
            'followDate': '2026-04-12T21:00:00',
          },
        ],
        'message': 'Takipci listesi basariyla getirildi.',
      });

      expect(response.isSuccess, isTrue);
      expect(response.users, isNotEmpty);
      expect(response.users?.first.followerUserName, 'ibrah');
      expect(response.users?.first.followingUserName, 'doctorx');
      expect(response.message, 'Takipci listesi basariyla getirildi.');
    });

    test('FollowCountResponseModel parses counts response', () {
      final response = FollowCountResponseModel.fromJson({
        'isSuccess': true,
        'data': {
          'userId': 2,
          'followersCount': 14,
          'followingCount': 9,
        },
        'message': 'Takip sayilari basariyla getirildi.',
      });

      expect(response.isSuccess, isTrue);
      expect(response.followCountModel?.userId, 2);
      expect(response.followCountModel?.followersCount, 14);
      expect(response.followCountModel?.followingCount, 9);
    });

    test('FollowStatusResponseModel parses follow status response', () {
      final response = FollowStatusResponseModel.fromJson({
        'isSuccess': true,
        'data': {
          'followerUserId': 1,
          'followingUserId': 2,
          'isFollowing': false,
          'followDate': null,
        },
        'message': 'Takip durumu basariyla getirildi.',
      });

      expect(response.isSuccess, isTrue);
      expect(response.followStatusModel?.followerUserId, 1);
      expect(response.followStatusModel?.followingUserId, 2);
      expect(response.followStatusModel?.isFollowing, isFalse);
      expect(response.followStatusModel?.followDate, isNull);
    });
  });

  group('Follow service paths', () {
    test('follow endpoints are mapped in ProductServicePath', () {
      expect(ProductServicePath.follow.value, 'api/follow/Follow');
      expect(ProductServicePath.unfollow.value, 'api/follow/Unfollow');
      expect(ProductServicePath.getFollowers.value, 'api/follow/GetFollowers');
      expect(ProductServicePath.getFollowing.value, 'api/follow/GetFollowing');
      expect(ProductServicePath.getFollowCounts.value, 'api/follow/GetCounts');
      expect(ProductServicePath.getFollowStatus.value, 'api/follow/GetStatus');
    });
  });
}
