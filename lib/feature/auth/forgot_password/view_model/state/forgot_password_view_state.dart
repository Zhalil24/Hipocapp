import 'package:equatable/equatable.dart';

final class ForgotPasswordViewState extends Equatable {
  ForgotPasswordViewState({required this.isLoading, this.serviceResponseMessage});

  final bool isLoading;
  final String? serviceResponseMessage;

  @override
  List<Object?> get props => [isLoading, serviceResponseMessage];

  ForgotPasswordViewState copyWith({bool? isLoading, String? serviceResponseMessage}) {
    return ForgotPasswordViewState(
      isLoading: isLoading ?? this.isLoading,
      serviceResponseMessage: serviceResponseMessage ?? this.serviceResponseMessage,
    );
  }
}
