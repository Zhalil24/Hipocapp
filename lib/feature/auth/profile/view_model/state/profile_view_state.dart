import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/product/utility/enums/profile_tab_type.dart';

final class ProfileViewState extends Equatable {
  ProfileViewState({required this.isLoading, this.profileModel, this.seviceResultMessage, this.activeTab = ProfileTabType.profile, this.photo});

  final bool isLoading;
  final String? seviceResultMessage;
  final ProfileModel? profileModel;
  final ProfileTabType activeTab;
  final File? photo;

  @override
  List<Object?> get props => [isLoading, profileModel, activeTab, photo, seviceResultMessage];

  ProfileViewState copyWith({bool? isLoading, ProfileModel? profileModel, ProfileTabType? activeTab, File? photo, String? seviceResultMessage}) {
    return ProfileViewState(
        isLoading: isLoading ?? this.isLoading,
        seviceResultMessage: seviceResultMessage ?? this.seviceResultMessage,
        profileModel: profileModel ?? this.profileModel,
        activeTab: activeTab ?? this.activeTab,
        photo: photo ?? this.photo);
  }
}
