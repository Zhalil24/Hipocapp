import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/product/utility/enums/profile_tab_type.dart';

final class ProfileViewState extends Equatable {
  ProfileViewState({required this.isLoading, this.profileModel, this.activeTab = ProfileTabType.profile, this.photo, this.serviceResponseMessage});

  final bool isLoading;
  final ProfileModel? profileModel;
  final ProfileTabType activeTab;
  final File? photo;
  final String? serviceResponseMessage;
  @override
  List<Object?> get props => [isLoading, profileModel, activeTab, photo, serviceResponseMessage];

  ProfileViewState copyWith({bool? isLoading, ProfileModel? profileModel, ProfileTabType? activeTab, File? photo, String? serviceResponseMessage}) {
    return ProfileViewState(
      isLoading: isLoading ?? this.isLoading,
      profileModel: profileModel ?? this.profileModel,
      activeTab: activeTab ?? this.activeTab,
      photo: photo ?? this.photo,
      serviceResponseMessage: serviceResponseMessage ?? this.serviceResponseMessage,
    );
  }
}
