import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';
import 'package:gen/src/model/degree/degree_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel extends INetworkModel<ProfileModel> with EquatableMixin {
  ProfileModel(
      {this.id,
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
      this.entries,
      this.passwordRefreshToken,
      this.isOnline,
      this.degreeModel});

  factory ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);

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
  final String? email;
  final String? passwordRefreshToken;
  final List<EntryModel>? entries;
  final bool? isOnline;
  final DegreeModel? degreeModel;

  @override
  List<Object?> get props => [
        id,
        rolId,
        iconId,
        degreeId,
        username,
        name,
        surname,
        identityNumber,
        imageURL,
        image,
        photoURL,
        email,
        passwordRefreshToken,
        entries,
        isOnline,
        degreeModel
      ];

  @override
  ProfileModel fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);

  ProfileModel copyWith(
      {int? id,
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
      String? photo,
      String? email,
      String? passwordRe,
      String? password,
      String? passwordRefreshToken,
      List<EntryModel>? entries,
      bool? isOnline,
      DegreeModel? degreeModel}) {
    return ProfileModel(
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
      entries: entries ?? this.entries,
      passwordRefreshToken: passwordRefreshToken ?? this.passwordRefreshToken,
      isOnline: isOnline ?? this.isOnline,
      degreeModel: degreeModel ?? this.degreeModel,
    );
  }
}
