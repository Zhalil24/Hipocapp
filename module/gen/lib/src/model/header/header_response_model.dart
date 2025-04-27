import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'header_response_model.g.dart';

@JsonSerializable()
class HeaderResponseModel extends INetworkModel<HeaderResponseModel> with EquatableMixin {
  final bool? isSuccess;
  @JsonKey(name: "data")
  final HeaderModel? header;
  final String? message;

  HeaderResponseModel({this.isSuccess, this.header, this.message});

  factory HeaderResponseModel.fromJson(Map<String, dynamic> json) => _$HeaderResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$HeaderResponseModelToJson(this);

  @override
  HeaderResponseModel fromJson(Map<String, dynamic> json) {
    return _$HeaderResponseModelFromJson(json);
  }

  @override
  List<Object?> get props => [isSuccess, header, message];
}
