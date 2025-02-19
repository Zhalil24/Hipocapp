import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';

final class HomeViewState extends Equatable {
  HomeViewState({required this.isLoading, this.users = const []});

  final bool isLoading;
  final List<User>? users;

  @override
  List<Object?> get props => [isLoading, users];

  HomeViewState copyWith({bool? isLoading, List<User>? users}) {
    return HomeViewState(
      isLoading: isLoading ?? this.isLoading,
      users: users ?? this.users,
    );
  }
}
