import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'group_message_list_response_model.g.dart';

@JsonSerializable()
class GroupMessageListResponseModel extends INetworkModel<GroupMessageListResponseModel> with EquatableMixin {
  final bool? isSuccess;
  @JsonKey(name: "data")
  final List<GroupMessageModel>? groupMessageModel;
  final String? message;

  GroupMessageListResponseModel({this.isSuccess, this.groupMessageModel, this.message});

  factory GroupMessageListResponseModel.fromJson(Map<String, dynamic> json) => _$GroupMessageListResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GroupMessageListResponseModelToJson(this);

  @override
  GroupMessageListResponseModel fromJson(Map<String, dynamic> json) {
    return _$GroupMessageListResponseModelFromJson(json);
  }

  @override
  List<Object?> get props => [isSuccess, groupMessageModel, message];
}
