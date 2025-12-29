import 'package:equatable/equatable.dart';
import 'package:gen/src/model/group_list/group_list_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'group_list_model_response.g.dart';

@JsonSerializable()
class GroupListResponseModel extends INetworkModel<GroupListResponseModel> with EquatableMixin {
  @JsonKey(name: "data")
  final List<GroupListModel>? groupList;

  GroupListResponseModel({this.groupList});

  factory GroupListResponseModel.fromJson(Map<String, dynamic> json) => _$GroupListResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GroupListResponseModelToJson(this);

  @override
  GroupListResponseModel fromJson(Map<String, dynamic> json) {
    return _$GroupListResponseModelFromJson(json);
  }

  @override
  List<Object?> get props => [groupList];
}
