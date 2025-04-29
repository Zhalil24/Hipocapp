import 'package:equatable/equatable.dart';
import 'package:gen/src/model/content/content_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'content_response_model.g.dart';

@JsonSerializable()
class ContentResponseModel extends INetworkModel<ContentResponseModel> with EquatableMixin {
  final bool? isSuccess;
  @JsonKey(name: "data")
  final List<ContentModel>? contentModel;
  final String? message;

  ContentResponseModel({this.isSuccess, this.contentModel, this.message});

  factory ContentResponseModel.fromJson(Map<String, dynamic> json) => _$ContentResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ContentResponseModelToJson(this);

  @override
  ContentResponseModel fromJson(Map<String, dynamic> json) {
    return _$ContentResponseModelFromJson(json);
  }

  @override
  List<Object?> get props => [isSuccess, contentModel, message];
}
