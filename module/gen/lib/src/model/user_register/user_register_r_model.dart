import 'package:equatable/equatable.dart';
import 'package:gen/src/model/user_image/user_image_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
part 'user_register_r_model.g.dart';

@JsonSerializable()
class UserRegisterRModel extends INetworkModel<UserRegisterRModel> with EquatableMixin {
  UserRegisterRModel({
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

  factory UserRegisterRModel.fromJson(Map<String, dynamic> json) => _$UserRegisterRModelFromJson(json);

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
  final UserImageModel? image;

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
  UserRegisterRModel fromJson(Map<String, dynamic> json) => _$UserRegisterRModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserRegisterRModelToJson(this);

  UserRegisterRModel copyWith({
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
    UserImageModel? image,
  }) {
    return UserRegisterRModel(
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
