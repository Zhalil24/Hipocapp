import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
import 'package:equatable/equatable.dart';

part 'degree_model.g.dart';

@JsonSerializable()
class DegreeModel extends INetworkModel<DegreeModel> with EquatableMixin {
  DegreeModel({this.degreeName, this.id});

  factory DegreeModel.fromJson(Map<String, dynamic> json) => _$DegreeModelFromJson(json);
  final int? id;
  final String? degreeName;

  @override
  List<Object?> get props => [degreeName, id];

  @override
  DegreeModel fromJson(Map<String, dynamic> json) => _$DegreeModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DegreeModelToJson(this);

  DegreeModel copyWith({String? degreeName, int? id}) {
    return DegreeModel(degreeName: degreeName ?? this.degreeName, id: id ?? this.id);
  }
}
