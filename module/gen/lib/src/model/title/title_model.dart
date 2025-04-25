import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
import 'package:equatable/equatable.dart';

part 'title_model.g.dart';

@JsonSerializable()
class TitleModel extends INetworkModel<TitleModel> with EquatableMixin {
  TitleModel({this.id, this.userId, this.headerId, this.name, this.createDate, this.updateDate});

  factory TitleModel.fromJson(Map<String, dynamic> json) => _$TitleModelFromJson(json);

  final int? id;
  final int? userId;
  final int? headerId;
  final String? name;
  final String? createDate;
  final String? updateDate;

  @override
  List<Object?> get props => [id, userId, headerId, name, createDate, updateDate];

  @override
  TitleModel fromJson(Map<String, dynamic> json) => _$TitleModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TitleModelToJson(this);

  TitleModel copyWith({
    int? id,
    int? userId,
    int? headerId,
    String? name,
    String? createDate,
    String? updateDate,
  }) {
    return TitleModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      headerId: headerId ?? this.headerId,
      name: name ?? this.name,
      createDate: createDate ?? this.createDate,
      updateDate: updateDate ?? this.updateDate,
    );
  }
}
