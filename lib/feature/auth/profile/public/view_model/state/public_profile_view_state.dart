import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';

final class PublicProfileViewState extends Equatable {
  const PublicProfileViewState({
    required this.isLoading,
    this.profileModel,
  });

  final bool isLoading;
  final ProfileModel? profileModel;

  @override
  List<Object?> get props => [isLoading, profileModel];

  PublicProfileViewState copyWith({
    bool? isLoading,
    ProfileModel? profileModel,
  }) {
    return PublicProfileViewState(
      isLoading: isLoading ?? this.isLoading,
      profileModel: profileModel ?? this.profileModel,
    );
  }
}
