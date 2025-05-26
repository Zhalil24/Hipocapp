import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'degree_response_model.g.dart';

@JsonSerializable()
class DegreeResponseModel extends INetworkModel<DegreeResponseModel> with EquatableMixin {
  final bool? isSuccess;
  @JsonKey(name: "data")
  final List<DegreeModel>? degree;
  final String? message;

  DegreeResponseModel({this.isSuccess, this.degree, this.message});

  factory DegreeResponseModel.fromJson(Map<String, dynamic> json) => _$DegreeResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DegreeResponseModelToJson(this);

  @override
  DegreeResponseModel fromJson(Map<String, dynamic> json) {
    return _$DegreeResponseModelFromJson(json);
  }

  @override
  List<Object?> get props => [isSuccess, degree, message];
}
