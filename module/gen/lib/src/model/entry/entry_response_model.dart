import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'entry_response_model.g.dart';

@JsonSerializable()
class EntryResponseModel extends INetworkModel<EntryResponseModel> with EquatableMixin {
  final bool? isSuccess;
  @JsonKey(name: "data")
  final EntryModel? entries;
  final String? message;

  EntryResponseModel({this.isSuccess, this.entries, this.message});

  factory EntryResponseModel.fromJson(Map<String, dynamic> json) => _$EntryResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EntryResponseModelToJson(this);

  @override
  EntryResponseModel fromJson(Map<String, dynamic> json) {
    return _$EntryResponseModelFromJson(json);
  }

  @override
  List<Object?> get props => [isSuccess, entries, message];
}
