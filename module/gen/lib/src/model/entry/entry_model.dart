import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
import 'package:equatable/equatable.dart';

part 'entry_model.g.dart';

@JsonSerializable()
class EntryModel extends INetworkModel<EntryModel> with EquatableMixin {
  EntryModel({this.headerId, this.titleName, this.description, this.isEntry, this.userId, this.id});

  factory EntryModel.fromJson(Map<String, dynamic> json) => _$EntryModelFromJson(json);
  final int? id;
  final int? headerId;
  final String? titleName;
  final String? description;
  final bool? isEntry;
  final int? userId;
  @override
  List<Object?> get props => [
        headerId,
        titleName,
        description,
        isEntry,
        userId,
        id,
      ];

  @override
  EntryModel fromJson(Map<String, dynamic> json) => _$EntryModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EntryModelToJson(this);

  EntryModel copyWith({int? headerId, String? titleName, bool? isEntry, String? description, int? userId, int? id}) {
    return EntryModel(
        headerId: headerId ?? this.headerId,
        titleName: titleName ?? this.titleName,
        isEntry: isEntry ?? this.isEntry,
        description: description ?? this.description,
        userId: userId ?? this.userId,
        id: id ?? this.id);
  }
}
