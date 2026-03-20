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
  });

  static const Object _sentinel = Object();

  final bool isLoading;
  final ProfileModel? profileModel;
  final ProfileTabType activeTab;
  final File? photo;
  final String? serviceResponseMessage;
  @override
  List<Object?> get props => [isLoading, profileModel, activeTab, photo, serviceResponseMessage];

  ProfileViewState copyWith({
    bool? isLoading,
    ProfileModel? profileModel,
    ProfileTabType? activeTab,
    Object? photo = _sentinel,
    Object? serviceResponseMessage = _sentinel,
  }) {
    return ProfileViewState(
      isLoading: isLoading ?? this.isLoading,
      profileModel: profileModel ?? this.profileModel,
      activeTab: activeTab ?? this.activeTab,
      photo: identical(photo, _sentinel) ? this.photo : photo as File?,
      serviceResponseMessage: identical(serviceResponseMessage, _sentinel)
          ? this.serviceResponseMessage
          : serviceResponseMessage as String?,
    );
  }
}
