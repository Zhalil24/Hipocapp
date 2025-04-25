import 'package:equatable/equatable.dart';

final class SplashViewState extends Equatable {
  SplashViewState({required this.isLoading, required this.isLoggedIn});

  final bool isLoading;
  final bool isLoggedIn;

  @override
  List<Object?> get props => [isLoading, isLoggedIn];

  SplashViewState copyWith({bool? isLoading, bool? isLoggedIn}) {
    return SplashViewState(isLoading: isLoading ?? this.isLoading, isLoggedIn: isLoggedIn ?? this.isLoggedIn);
  }
}
