import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ProdcutState extends Equatable {
  const ProdcutState({this.themeMode = ThemeMode.light});

  final ThemeMode themeMode;
  @override
  List<Object?> get props => [themeMode];

  ProdcutState copyWith({
    ThemeMode? themeMode,
  }) {
    return ProdcutState(themeMode: themeMode ?? this.themeMode);
  }
}
