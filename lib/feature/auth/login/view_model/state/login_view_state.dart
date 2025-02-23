import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';

final class LoginViewState extends Equatable {
  LoginViewState({required this.isLoading});

  final bool isLoading;

  @override
  List<Object?> get props => [isLoading];

  LoginViewState copyWith({bool? isLoading, List<User>? users}) {
    return LoginViewState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
