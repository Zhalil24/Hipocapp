import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
part 'user_register_model.g.dart';

@JsonSerializable()
class UserRegisterModel extends INetworkModel<UserRegisterModel> with EquatableMixin {
  UserRegisterModel({
    this.degreeId,
    this.isTermsAccepted,
    this.password,
    this.passwordRepeat,
    this.username,
    this.name,
    this.imageURL,
    this.surname,
    this.identityNumber,
    this.phoneNumber,
    this.image,
    this.email,
  });

  factory UserRegisterModel.fromJson(Map<String, dynamic> json) => _$UserRegisterModelFromJson(json);

  final String? username;
  final String? name;
  final String? surname;
  final String? email;
  final String? phoneNumber;
  final String? identityNumber;
  final String? password;
  final String? passwordRepeat;
  final String? imageURL;
  final int? degreeId;
  final bool? isTermsAccepted;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final File? image;

  @override
  List<Object?> get props => [
        username,
        name,
        surname,
        email,
        phoneNumber,
        identityNumber,
        password,
        passwordRepeat,
        imageURL,
        degreeId,
        isTermsAccepted,
        image,
      ];

  @override
  UserRegisterModel fromJson(Map<String, dynamic> json) => _$UserRegisterModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserRegisterModelToJson(this);

  UserRegisterModel copyWith({
    String? username,
    String? name,
    String? surname,
    String? email,
    String? phoneNumber,
    String? identityNumber,
    String? password,
    String? passwordRepeat,
    String? imageURL,
    int? degreeId,
    bool? isTermsAccepted,
    File? image,
  }) {
    return UserRegisterModel(
      degreeId: degreeId ?? this.degreeId,
      username: username ?? this.username,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      identityNumber: identityNumber ?? this.identityNumber,
      imageURL: imageURL ?? this.imageURL,
      image: image ?? this.image,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordRepeat: passwordRepeat ?? this.passwordRepeat,
      isTermsAccepted: isTermsAccepted ?? this.isTermsAccepted,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
