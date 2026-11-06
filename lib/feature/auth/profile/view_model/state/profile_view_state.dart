import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/product/utility/enums/profile_tab_type.dart';

final class ProfileViewState extends Equatable {
  const ProfileViewState({
    required this.isLoading,
    this.profileModel,
    this.activeTab = ProfileTabType.profile,
    this.photo,
    this.serviceResponseMessage,
    this.followCountModel,
    this.followStatusModel,
    this.followers = const <FollowUserItemModel>[],
    this.following = const <FollowUserItemModel>[],
    this.isFollowActionLoading = false,
  });

  static const Object _sentinel = Object();

  final bool isLoading;
  final ProfileModel? profileModel;
  final ProfileTabType activeTab;
  final File? photo;
  final String? serviceResponseMessage;
  final FollowCountModel? followCountModel;
  final FollowStatusModel? followStatusModel;
  final List<FollowUserItemModel> followers;
  final List<FollowUserItemModel> following;
  final bool isFollowActionLoading;
  @override
  List<Object?> get props => [
        isLoading,
        profileModel,
        activeTab,
        photo,
        serviceResponseMessage,
        followCountModel,
        followStatusModel,
        followers,
        following,
        isFollowActionLoading,
      ];

  ProfileViewState copyWith({
    bool? isLoading,
    ProfileModel? profileModel,
    ProfileTabType? activeTab,
    Object? photo = _sentinel,
    Object? serviceResponseMessage = _sentinel,
    Object? followCountModel = _sentinel,
    Object? followStatusModel = _sentinel,
    List<FollowUserItemModel>? followers,
    List<FollowUserItemModel>? following,
    bool? isFollowActionLoading,
  }) {
    return ProfileViewState(
      isLoading: isLoading ?? this.isLoading,
      profileModel: profileModel ?? this.profileModel,
      activeTab: activeTab ?? this.activeTab,
      photo: identical(photo, _sentinel) ? this.photo : photo as File?,
      serviceResponseMessage: identical(serviceResponseMessage, _sentinel)
          ? this.serviceResponseMessage
          : serviceResponseMessage as String?,
      followCountModel: identical(followCountModel, _sentinel)
          ? this.followCountModel
          : followCountModel as FollowCountModel?,
      followStatusModel: identical(followStatusModel, _sentinel)
          ? this.followStatusModel
          : followStatusModel as FollowStatusModel?,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      isFollowActionLoading:
          isFollowActionLoading ?? this.isFollowActionLoading,
    );
  }
}
