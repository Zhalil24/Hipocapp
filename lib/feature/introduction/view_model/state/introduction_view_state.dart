import 'package:equatable/equatable.dart';

final class IntroductionViewState extends Equatable {
  IntroductionViewState({required this.isLoading});

  final bool isLoading;

  @override
  List<Object?> get props => [isLoading];

  IntroductionViewState copyWith({bool? isLoading}) {
    return IntroductionViewState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
