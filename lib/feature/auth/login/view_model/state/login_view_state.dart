import 'package:equatable/equatable.dart';

final class LoginViewState extends Equatable {
  LoginViewState({required this.isLoading, this.serviceResponseMessage});

  final bool isLoading;
  final String? serviceResponseMessage;

  @override
  List<Object?> get props => [isLoading, serviceResponseMessage];

  LoginViewState copyWith({bool? isLoading, String? serviceResponseMessage}) {
    return LoginViewState(
      isLoading: isLoading ?? this.isLoading,
      serviceResponseMessage: serviceResponseMessage ?? this.serviceResponseMessage,
    );
  }
}
