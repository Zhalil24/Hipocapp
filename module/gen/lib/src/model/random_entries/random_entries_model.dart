import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
import 'package:equatable/equatable.dart';

part 'random_entries_model.g.dart';

@JsonSerializable()
class RandomEntriesModel extends INetworkModel<RandomEntriesModel> with EquatableMixin {
  RandomEntriesModel({
    this.id,
    this.userId,
    this.headerId,
    this.titleName,
    this.description,
    this.createDate,
    this.isEntry,
  });

  factory RandomEntriesModel.fromJson(Map<String, dynamic> json) => _$RandomEntriesModelFromJson(json);

  final int? id;
  final int? userId;
  final int? headerId;
  final String? titleName;
  final String? description;
  final String? createDate;
  final bool? isEntry;

  @override
  List<Object?> get props => [id, userId, titleName, headerId, description, createDate, isEntry];

  @override
  RandomEntriesModel fromJson(Map<String, dynamic> json) => _$RandomEntriesModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RandomEntriesModelToJson(this);

  RandomEntriesModel copyWith({
    int? id,
    int? userId,
    int? headerId,
    String? titleName,
    String? description,
    String? createDate,
    bool? isEntry,
  }) {
    return RandomEntriesModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      headerId: headerId ?? this.headerId,
      titleName: titleName ?? this.titleName,
      description: description ?? this.description,
      createDate: createDate ?? this.createDate,
      isEntry: isEntry ?? this.isEntry,
    );
  }
}
