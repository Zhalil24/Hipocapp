import 'package:equatable/equatable.dart';
import 'package:gen/src/model/access_token/access_token_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
part 'user.g.dart';

@JsonSerializable()
class User extends INetworkModel<User> with EquatableMixin {
  User({
    this.id,
    this.rolId,
    this.iconId,
    this.degreeId,
    this.username,
    this.name,
    this.surname,
    this.identityNumber,
    this.imageURL,
    this.image,
    this.photoURL,
    this.email,
    this.password,
    this.passwordRe,
    this.accessToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final int? id;
  final int? rolId;
  final int? iconId;
  final int? degreeId;
  final String? username;
  final String? name;
  final String? surname;
  final String? identityNumber;
  final String? imageURL;
  final String? image;
  final String? photoURL;
  final String? password;
  final String? passwordRe;
  final String? email;
  final AccessTokenModel? accessToken;

  @override
  List<Object?> get props =>
      [id, rolId, iconId, degreeId, username, name, surname, identityNumber, imageURL, image, photoURL, accessToken, password, passwordRe, email];

  @override
  User fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    int? id,
    int? rolId,
    int? iconId,
    int? degreeId,
    String? username,
    String? name,
    String? surname,
    String? identityNumber,
    String? imageURL,
    String? image,
    String? photoURL,
    String? email,
    String? passwordRe,
    String? password,
    AccessTokenModel? accessToken,
  }) {
    return User(
        id: id ?? this.id,
        rolId: rolId ?? this.rolId,
        iconId: iconId ?? this.iconId,
        degreeId: degreeId ?? this.degreeId,
        username: username ?? this.username,
        name: name ?? this.name,
        surname: surname ?? this.surname,
        identityNumber: identityNumber ?? this.identityNumber,
        imageURL: imageURL ?? this.imageURL,
        image: image ?? this.image,
        photoURL: photoURL ?? this.photoURL,
        email: email ?? this.email,
        password: password ?? this.password,
        passwordRe: passwordRe ?? this.passwordRe,
        accessToken: accessToken ?? this.accessToken);
  }
}
