import 'package:equatable/equatable.dart';
import 'package:gen/src/model/message_list/message_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'message_list_response_model.g.dart';

@JsonSerializable()
class MessageListResponseModel extends INetworkModel<MessageListResponseModel> with EquatableMixin {
  final bool? isSuccess;
  @JsonKey(name: "data")
  final List<MessageListModel>? messages;
  final String? message;

  MessageListResponseModel({this.isSuccess, this.messages, this.message});

  factory MessageListResponseModel.fromJson(Map<String, dynamic> json) => _$MessageListResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MessageListResponseModelToJson(this);

  @override
  MessageListResponseModel fromJson(Map<String, dynamic> json) {
    return _$MessageListResponseModelFromJson(json);
  }

  @override
  List<Object?> get props => [isSuccess, messages, message];
}
