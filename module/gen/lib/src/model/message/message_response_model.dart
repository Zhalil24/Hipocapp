import 'package:equatable/equatable.dart';
import 'package:gen/src/model/message/message_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'message_response_model.g.dart';

@JsonSerializable()
class MessageResponseModel extends INetworkModel<MessageResponseModel> with EquatableMixin {
  final bool? isSuccess;
  @JsonKey(name: "data")
  final List<MessageModel>? messages;
  final String? message;

  MessageResponseModel({this.isSuccess, this.messages, this.message});

  factory MessageResponseModel.fromJson(Map<String, dynamic> json) => _$MessageResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MessageResponseModelToJson(this);

  @override
  MessageResponseModel fromJson(Map<String, dynamic> json) {
    return _$MessageResponseModelFromJson(json);
  }

  @override
  List<Object?> get props => [isSuccess, messages, message];
}
