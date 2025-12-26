import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ProdcutState extends Equatable {
  const ProdcutState({this.themeMode = ThemeMode.light, this.serviceMessage, this.isLogin = false, this.currentUserId, this.userName});
  final String? serviceMessage;
  final ThemeMode themeMode;
  final bool isLogin;
  final int? currentUserId;
  final String? userName;
  @override
  List<Object?> get props => [themeMode, serviceMessage, isLogin, currentUserId, userName];

  ProdcutState copyWith({
    ThemeMode? themeMode,
    String? serviceMessage,
    bool? isLogin,
    int? currentUserId,
    String? userName,
  }) {
    return ProdcutState(
      isLogin: isLogin ?? this.isLogin,
      themeMode: themeMode ?? this.themeMode,
      serviceMessage: serviceMessage ?? this.serviceMessage,
      currentUserId: currentUserId ?? this.currentUserId,
      userName: userName ?? this.userName,
    );
  }
}
