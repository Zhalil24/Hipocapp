import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'last_entries_response_model.g.dart';

@JsonSerializable()
class LastEntiresResponseModel extends INetworkModel<LastEntiresResponseModel> with EquatableMixin {
  final bool? isSuccess;
  @JsonKey(name: "data")
  final List<LastEntriesModel>? lastEntries;
  final String? message;

  LastEntiresResponseModel({this.isSuccess, this.lastEntries, this.message});

  factory LastEntiresResponseModel.fromJson(Map<String, dynamic> json) => _$LastEntiresResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LastEntiresResponseModelToJson(this);

  @override
  LastEntiresResponseModel fromJson(Map<String, dynamic> json) {
    return _$LastEntiresResponseModelFromJson(json);
  }

  @override
  List<Object?> get props => [isSuccess, lastEntries, message];
}
