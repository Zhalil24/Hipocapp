import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
import 'package:equatable/equatable.dart';

part 'last_entries_model.g.dart';

@JsonSerializable()
class LastEntriesModel extends INetworkModel<LastEntriesModel> with EquatableMixin {
  LastEntriesModel({
    this.id,
    this.userId,
    this.titleName,
    this.entryDescription,
    this.userNameSurname,
    this.image,
    this.userName,
    this.date,
  });

  factory LastEntriesModel.fromJson(Map<String, dynamic> json) => _$LastEntriesModelFromJson(json);

  final int? id;
  final int? userId;
  final String? titleName;
  final String? entryDescription;
  final String? userNameSurname;
  final String? image;
  final String? userName;
  final String? date;

  @override
  List<Object?> get props => [id, userId, titleName, entryDescription, userNameSurname, image, userName, date];

  @override
  LastEntriesModel fromJson(Map<String, dynamic> json) => _$LastEntriesModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LastEntriesModelToJson(this);

  LastEntriesModel copyWith({
    int? id,
    int? userId,
    String? titleName,
    String? entryDescription,
    String? userNameSurname,
    String? image,
    String? userName,
    String? date,
  }) {
    return LastEntriesModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      titleName: titleName ?? this.titleName,
      entryDescription: entryDescription ?? this.entryDescription,
      userNameSurname: userNameSurname ?? this.userNameSurname,
      image: image ?? this.image,
      userName: userName ?? this.userName,
      date: date ?? this.date,
    );
  }
}
