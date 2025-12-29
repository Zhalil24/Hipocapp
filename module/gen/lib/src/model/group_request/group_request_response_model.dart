import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'group_request_response_model.g.dart';

@JsonSerializable()
class GroupRequestResponseModel extends INetworkModel<GroupRequestResponseModel> with EquatableMixin {
  final bool? isSuccess;
  final String? message;

  GroupRequestResponseModel({this.isSuccess, this.message});

  factory GroupRequestResponseModel.fromJson(Map<String, dynamic> json) => _$GroupRequestResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GroupRequestResponseModelToJson(this);

  @override
  GroupRequestResponseModel fromJson(Map<String, dynamic> json) {
    return _$GroupRequestResponseModelFromJson(json);
  }

  @override
  List<Object?> get props => [isSuccess, message];
}
