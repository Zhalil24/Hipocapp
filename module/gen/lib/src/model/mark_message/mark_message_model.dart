import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
import 'package:equatable/equatable.dart';

part 'mark_message_model.g.dart';

@JsonSerializable()
class MarkMessageModel extends INetworkModel<MarkMessageModel> with EquatableMixin {
  MarkMessageModel({this.fromUserId, this.toUserId});

  factory MarkMessageModel.fromJson(Map<String, dynamic> json) => _$MarkMessageModelFromJson(json);

  final int? fromUserId;
  final int? toUserId;

  @override
  List<Object?> get props => [
        fromUserId,
        toUserId,
      ];

  @override
  MarkMessageModel fromJson(Map<String, dynamic> json) => _$MarkMessageModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MarkMessageModelToJson(this);

  MarkMessageModel copyWith({
    int? fromUserId,
    int? toUserId,
  }) {
    return MarkMessageModel(
      fromUserId: fromUserId ?? this.fromUserId,
      toUserId: toUserId ?? this.toUserId,
    );
  }
}
