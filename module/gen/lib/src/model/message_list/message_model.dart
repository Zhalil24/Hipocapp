import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
import 'package:equatable/equatable.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageListModel extends INetworkModel<MessageListModel> with EquatableMixin {
  MessageListModel({
    this.id,
    this.fromUserId,
    this.toUserId,
    this.messageText,
    this.sentAt,
    this.isRead,
  });

  factory MessageListModel.fromJson(Map<String, dynamic> json) => _$MessageListModelFromJson(json);

  @JsonKey(name: 'Id')
  final int? id;

  @JsonKey(name: 'FromUserId')
  final int? fromUserId;

  @JsonKey(name: 'ToUserId')
  final int? toUserId;

  @JsonKey(name: 'MessageText')
  final String? messageText;

  @JsonKey(name: 'SentAt')
  final String? sentAt;

  @JsonKey(name: 'IsRead')
  final bool? isRead;

  @override
  List<Object?> get props => [id, fromUserId, toUserId, messageText, sentAt, isRead];

  @override
  MessageListModel fromJson(Map<String, dynamic> json) => _$MessageListModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MessageListModelToJson(this);

  MessageListModel copyWith({
    int? id,
    int? fromUserId,
    int? toUserId,
    String? messageText,
    String? sentAt,
    bool? isRead,
  }) {
    return MessageListModel(
      id: id ?? this.id,
      fromUserId: fromUserId ?? this.fromUserId,
      toUserId: toUserId ?? this.toUserId,
      messageText: messageText ?? this.messageText,
      sentAt: sentAt ?? this.sentAt,
      isRead: isRead ?? this.isRead,
    );
  }

  void add(MessageListModel message) {}
}
