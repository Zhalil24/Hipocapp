import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'entry_list_response_model.g.dart';

@JsonSerializable()
class EntryListResponseModel extends INetworkModel<EntryListResponseModel> with EquatableMixin {
  final bool? isSuccess;
  @JsonKey(name: "data")
  final List<EntryListModel>? entryListModel;
  final String? message;

  EntryListResponseModel({this.isSuccess, this.entryListModel, this.message});

  factory EntryListResponseModel.fromJson(Map<String, dynamic> json) => _$EntryListResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EntryListResponseModelToJson(this);

  @override
  EntryListResponseModel fromJson(Map<String, dynamic> json) {
    return _$EntryListResponseModelFromJson(json);
  }

  @override
  List<Object?> get props => [isSuccess, entryListModel, message];
}
