import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'base_response_model.g.dart';

@JsonSerializable()
class BaseResponseModel extends INetworkModel<BaseResponseModel> with EquatableMixin {
  final bool? isSuccess;
  final dynamic data;
  final String? message;

  BaseResponseModel({this.isSuccess, this.data, this.message});

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) => _$BaseResponseModelFromJson(json);

  @override
  BaseResponseModel fromJson(Map<String, dynamic> json) => BaseResponseModel.fromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BaseResponseModelToJson(this);

  @override
  List<Object?> get props => [isSuccess, data, message];
}
