import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'user_response_model.g.dart';

@JsonSerializable()
class UserResponseModel extends INetworkModel<UserResponseModel> with EquatableMixin {
  final bool? isSuccess;
  @JsonKey(name: "data") // ✅ API'den gelen `data` alanını `user` olarak eşleştiriyoruz
  final User? user;
  final String? message;

  UserResponseModel({this.isSuccess, this.user, this.message});

  /// JSON'dan nesne oluşturur
  factory UserResponseModel.fromJson(Map<String, dynamic> json) => _$UserResponseModelFromJson(json);

  /// Nesneyi JSON'a çevirir
  @override
  Map<String, dynamic> toJson() => _$UserResponseModelToJson(this);

  /// INetworkModel.fromJson metodu için
  @override
  UserResponseModel fromJson(Map<String, dynamic> json) => UserResponseModel.fromJson(json);

  @override
  List<Object?> get props => [isSuccess, user, message];
}
