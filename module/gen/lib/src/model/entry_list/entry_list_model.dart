import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
import 'package:equatable/equatable.dart';

part 'entry_list_model.g.dart';

@JsonSerializable()
class EntryListModel extends INetworkModel<EntryListModel> with EquatableMixin {
  EntryListModel({this.id, this.userId, this.titleName, this.entryDescription, this.userNameSurname, this.userName, this.date});

  factory EntryListModel.fromJson(Map<String, dynamic> json) => _$EntryListModelFromJson(json);

  final int? id;
  final int? userId;
  final String? titleName;
  final String? entryDescription;
  final String? userNameSurname;
  final String? userName;
  final String? date;

  @override
  List<Object?> get props => [id, userId, titleName, entryDescription, userNameSurname, userName, date];

  @override
  EntryListModel fromJson(Map<String, dynamic> json) => _$EntryListModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EntryListModelToJson(this);

  EntryListModel copyWith({
    int? id,
    int? userId,
    String? titleName,
    String? entryDescription,
    String? userNameSurname,
    String? userName,
    String? date,
  }) {
    return EntryListModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      titleName: titleName ?? this.titleName,
      entryDescription: entryDescription ?? this.entryDescription,
      userNameSurname: userNameSurname ?? this.userNameSurname,
      userName: userName ?? this.userName,
      date: date ?? this.date,
    );
  }
}
