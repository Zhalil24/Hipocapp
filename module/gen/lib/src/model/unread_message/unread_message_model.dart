import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
import 'package:equatable/equatable.dart';

part 'unread_message_model.g.dart';

@JsonSerializable()
class UnReadMessageModel extends INetworkModel<UnReadMessageModel> with EquatableMixin {
  UnReadMessageModel({
    this.count,
    this.fromUserId,
  });

  factory UnReadMessageModel.fromJson(Map<String, dynamic> json) => _$UnReadMessageModelFromJson(json);

  final int? count;
  final int? fromUserId;

  @override
  List<Object?> get props => [count, fromUserId];

  @override
  UnReadMessageModel fromJson(Map<String, dynamic> json) => _$UnReadMessageModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UnReadMessageModelToJson(this);

  UnReadMessageModel copyWith({
    int? count,
    int? fromUserId,
  }) {
    return UnReadMessageModel(
      count: count ?? this.count,
      fromUserId: fromUserId ?? this.fromUserId,
    );
  }
}
