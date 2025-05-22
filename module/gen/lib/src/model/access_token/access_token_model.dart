import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'access_token_model.g.dart';

@JsonSerializable()

/// Access Token Model
class AccessTokenModel extends INetworkModel<AccessTokenModel> with EquatableMixin {
  AccessTokenModel({
    this.token,
    this.reToken,
    this.expiration,
  });

  factory AccessTokenModel.fromJson(Map<String, dynamic> json) => _$AccessTokenModelFromJson(json);

  final String? token;
  final String? reToken;
  final DateTime? expiration;

  @override
  List<Object?> get props => [token, reToken, expiration];

  @override
  AccessTokenModel fromJson(Map<String, dynamic> json) => _$AccessTokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccessTokenModelToJson(this);

  AccessTokenModel copyWith({
    String? token,
    String? reToken,
    DateTime? expiration,
  }) {
    return AccessTokenModel(
      token: token ?? this.token,
      reToken: reToken ?? this.reToken,
      expiration: expiration ?? this.expiration,
    );
  }
}
