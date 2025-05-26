import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';

final class RegisterViewState extends Equatable {
  RegisterViewState({required this.isLoading, this.degree, this.serviceResponseMessage});

  final bool isLoading;
  final List<DegreeModel>? degree;
  final String? serviceResponseMessage;

  @override
  List<Object?> get props => [isLoading, degree, serviceResponseMessage];

  RegisterViewState copyWith({bool? isLoading, List<DegreeModel>? degree, String? serviceResponseMessage}) {
    return RegisterViewState(
      isLoading: isLoading ?? this.isLoading,
      degree: degree ?? this.degree,
      serviceResponseMessage: serviceResponseMessage ?? this.serviceResponseMessage,
    );
  }
}
