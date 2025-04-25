import 'package:equatable/equatable.dart';

final class DrawerViewState extends Equatable {
  DrawerViewState({required this.isLoading});
  final bool isLoading;

  @override
  List<Object?> get props => [isLoading];

  DrawerViewState copyWith({bool? isLoading}) {
    return DrawerViewState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
