import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
import 'package:equatable/equatable.dart';

part 'content_model.g.dart';

@JsonSerializable()
class ContentModel extends INetworkModel<ContentModel> with EquatableMixin {
  ContentModel({this.imageURL, this.description, this.title, this.link, this.id});

  factory ContentModel.fromJson(Map<String, dynamic> json) => _$ContentModelFromJson(json);
  final int? id;
  final String? imageURL;
  final String? description;
  final String? title;
  final String? link;

  @override
  List<Object?> get props => [imageURL, description, title, link, id];

  @override
  ContentModel fromJson(Map<String, dynamic> json) => _$ContentModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ContentModelToJson(this);

  ContentModel copyWith({
    int? id,
    String? imageURL,
    String? description,
    String? title,
    String? link,
  }) {
    return ContentModel(
      id: id ?? this.id,
      imageURL: imageURL ?? this.imageURL,
      description: description ?? this.description,
      title: title ?? this.title,
      link: link ?? this.link,
    );
  }
}
