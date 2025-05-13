import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
import 'package:equatable/equatable.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel extends INetworkModel<MessageModel> with EquatableMixin {
  MessageModel({this.id, this.fromUserId, this.toUserId, this.messageText, this.sentAt, this.isRead});

  factory MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);

  final int? id;
  final int? fromUserId;
  final int? toUserId;
  final String? messageText;
  final String? sentAt;
  final bool? isRead;

  @override
  List<Object?> get props => [id, fromUserId, toUserId, messageText, sentAt, isRead];

  @override
  MessageModel fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MessageModelToJson(this);

  MessageModel copyWith({
    int? id,
    int? fromUserId,
    int? toUserId,
    String? messageText,
    String? sentAt,
    bool? isRead,
  }) {
    return MessageModel(
      id: id ?? this.id,
      fromUserId: fromUserId ?? this.fromUserId,
      toUserId: toUserId ?? this.toUserId,
      messageText: messageText ?? this.messageText,
      sentAt: sentAt ?? this.sentAt,
      isRead: isRead ?? this.isRead,
    );
  }
}
