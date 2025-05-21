import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
import 'package:equatable/equatable.dart';

part 'group_message_model.g.dart';

@JsonSerializable()
class GroupMessageModel extends INetworkModel<GroupMessageModel> with EquatableMixin {
  GroupMessageModel({this.groupId, this.fromUserId, this.messageText, this.sentOn, this.fromUserName});

  factory GroupMessageModel.fromJson(Map<String, dynamic> json) => _$GroupMessageModelFromJson(json);

  final int? fromUserId;
  final int? groupId;
  final String? messageText;
  final String? sentOn;
  final String? fromUserName;

  @override
  List<Object?> get props => [groupId, fromUserId, messageText, sentOn, fromUserName];

  @override
  GroupMessageModel fromJson(Map<String, dynamic> json) => _$GroupMessageModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GroupMessageModelToJson(this);

  GroupMessageModel copyWith({
    int? groupId,
    int? fromUserId,
    String? messageText,
    String? sentOn,
    String? fromUserName,
  }) {
    return GroupMessageModel(
      groupId: groupId ?? this.groupId,
      fromUserId: fromUserId ?? this.fromUserId,
      messageText: messageText ?? this.messageText,
      sentOn: sentOn ?? this.sentOn,
      fromUserName: fromUserName ?? this.fromUserName,
    );
  }
}
