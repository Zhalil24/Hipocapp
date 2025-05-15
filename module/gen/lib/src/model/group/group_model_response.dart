import 'package:equatable/equatable.dart';
import 'package:gen/src/model/group/group_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'group_model_response.g.dart';

@JsonSerializable()
class GroupResponseModel extends INetworkModel<GroupResponseModel> with EquatableMixin {
  @JsonKey(name: "data")
  final List<GroupModel>? group;

  GroupResponseModel({this.group});

  factory GroupResponseModel.fromJson(Map<String, dynamic> json) => _$GroupResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GroupResponseModelToJson(this);

  @override
  GroupResponseModel fromJson(Map<String, dynamic> json) {
    return _$GroupResponseModelFromJson(json);
  }

  @override
  List<Object?> get props => [group];
}
