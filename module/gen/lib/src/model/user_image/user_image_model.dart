import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
import 'package:equatable/equatable.dart';

part 'user_image_model.g.dart';

@JsonSerializable()
class UserImageModel extends INetworkModel<UserImageModel> with EquatableMixin {
  UserImageModel({this.contentDisposition, this.contentType, this.headers, this.length, this.name, this.fileName});

  factory UserImageModel.fromJson(Map<String, dynamic> json) => _$UserImageModelFromJson(json);

  final String? contentDisposition;
  final String? contentType;
  final Map<String, List<String>>? headers;
  final int? length;
  final String? name;
  final String? fileName;

  @override
  List<Object?> get props => [contentDisposition, contentType, headers, name, length, fileName];

  @override
  UserImageModel fromJson(Map<String, dynamic> json) => _$UserImageModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserImageModelToJson(this);

  UserImageModel copyWith({
    String? contentDisposition,
    String? contentType,
    Map<String, List<String>>? headers,
    int? length,
    String? name,
    String? fileName,
  }) {
    return UserImageModel(
      contentDisposition: contentDisposition ?? this.contentDisposition,
      contentType: contentType ?? this.contentType,
      headers: headers ?? this.headers,
      length: length ?? this.length,
      name: name ?? this.name,
      fileName: fileName ?? this.fileName,
    );
  }
}
