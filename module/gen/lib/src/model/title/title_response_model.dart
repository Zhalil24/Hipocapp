import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'title_response_model.g.dart';

@JsonSerializable()
class TitleResponseModel extends INetworkModel<TitleResponseModel> with EquatableMixin {
  final bool? isSuccess;
  @JsonKey(name: "data")
  final List<TitleModel>? titles;
  final String? message;

  TitleResponseModel({this.isSuccess, this.titles, this.message});

  factory TitleResponseModel.fromJson(Map<String, dynamic> json) => _$TitleResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TitleResponseModelToJson(this);

  @override
  TitleResponseModel fromJson(Map<String, dynamic> json) {
    return _$TitleResponseModelFromJson(json);
  }

  @override
  List<Object?> get props => [isSuccess, titles, message];
}
