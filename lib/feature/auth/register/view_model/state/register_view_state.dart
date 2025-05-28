import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';

final class RegisterViewState extends Equatable {
  RegisterViewState({
    required this.isLoading,
    this.degree,
    this.serviceResponseMessage,
    this.photo,
    this.degreeId = 2,
    required this.isCheck,
  });

  final bool isLoading;
  final List<DegreeModel>? degree;
  final String? serviceResponseMessage;
  final File? photo;
  final int? degreeId;
  final bool isCheck;
  @override
  List<Object?> get props => [
        isLoading,
        degree,
        serviceResponseMessage,
        photo,
        degreeId,
        isCheck,
      ];

  RegisterViewState copyWith({
    bool? isLoading,
    List<DegreeModel>? degree,
    String? serviceResponseMessage,
    File? photo,
    int? degreeId,
    bool? isCheck,
  }) {
    return RegisterViewState(
      isLoading: isLoading ?? this.isLoading,
      degree: degree ?? this.degree,
      serviceResponseMessage: serviceResponseMessage ?? this.serviceResponseMessage,
      degreeId: degreeId ?? this.degreeId,
      photo: photo ?? this.photo,
      isCheck: isCheck ?? this.isCheck,
    );
  }
}
