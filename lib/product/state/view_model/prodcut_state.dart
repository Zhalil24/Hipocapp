import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ProdcutState extends Equatable {
  const ProdcutState({this.themeMode = ThemeMode.light, this.serviceMessage});
  final String? serviceMessage;
  final ThemeMode themeMode;
  @override
  List<Object?> get props => [themeMode, serviceMessage];

  ProdcutState copyWith({
    ThemeMode? themeMode,
    String? serviceMessage,
  }) {
    return ProdcutState(
      themeMode: themeMode ?? this.themeMode,
      serviceMessage: serviceMessage ?? this.serviceMessage,
    );
  }
}
