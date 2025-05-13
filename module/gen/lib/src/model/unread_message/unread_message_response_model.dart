import 'package:equatable/equatable.dart';
import 'package:gen/src/model/unread_message/unread_message_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'unread_message_response_model.g.dart';

@JsonSerializable()
class UnReadMessageResponseModel extends INetworkModel<UnReadMessageResponseModel> with EquatableMixin {
  final bool? isSuccess;
  @JsonKey(name: "data")
  final List<UnReadMessageModel>? unreadCounts;

  UnReadMessageResponseModel({this.isSuccess, this.unreadCounts});

  factory UnReadMessageResponseModel.fromJson(Map<String, dynamic> json) => _$UnReadMessageResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UnReadMessageResponseModelToJson(this);

  @override
  UnReadMessageResponseModel fromJson(Map<String, dynamic> json) {
    return _$UnReadMessageResponseModelFromJson(json);
  }

  @override
  List<Object?> get props => [isSuccess, unreadCounts];
}
