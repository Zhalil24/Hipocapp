import 'package:equatable/equatable.dart';
import 'package:gen/src/model/random_entries/random_entries_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'random_entries_response_model.g.dart';

@JsonSerializable()
class RandomEntriesResponseModel extends INetworkModel<RandomEntriesResponseModel> with EquatableMixin {
  final bool? isSuccess;
  @JsonKey(name: "data")
  final List<RandomEntriesModel>? randomEntries;
  final String? message;

  RandomEntriesResponseModel({this.isSuccess, this.randomEntries, this.message});

  factory RandomEntriesResponseModel.fromJson(Map<String, dynamic> json) => _$RandomEntriesResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RandomEntriesResponseModelToJson(this);

  @override
  RandomEntriesResponseModel fromJson(Map<String, dynamic> json) {
    return _$RandomEntriesResponseModelFromJson(json);
  }

  @override
  List<Object?> get props => [isSuccess, randomEntries, message];
}
