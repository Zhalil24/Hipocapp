import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'group_message_response_model.g.dart';

@JsonSerializable()
class GroupMessageResponseModel extends INetworkModel<GroupMessageResponseModel> with EquatableMixin {
  final bool? isSuccess;
  @JsonKey(name: "data")
  final GroupMessageModel? groupMessageModel;
  final String? message;

  GroupMessageResponseModel({this.isSuccess, this.groupMessageModel, this.message});

  factory GroupMessageResponseModel.fromJson(Map<String, dynamic> json) => _$GroupMessageResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GroupMessageResponseModelToJson(this);

  @override
  GroupMessageResponseModel fromJson(Map<String, dynamic> json) {
    return _$GroupMessageResponseModelFromJson(json);
  }

  @override
  List<Object?> get props => [isSuccess, groupMessageModel, message];
}
