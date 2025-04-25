import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
import 'package:equatable/equatable.dart';

part 'header_model.g.dart';

@JsonSerializable()
class HeaderModel extends INetworkModel<HeaderModel> with EquatableMixin {
  HeaderModel({this.id, this.text, this.upHeaderId, this.discriminator});

  factory HeaderModel.fromJson(Map<String, dynamic> json) => _$HeaderModelFromJson(json);

  final int? id;
  final String? text;
  final int? upHeaderId;
  final String? discriminator;

  @override
  List<Object?> get props => [id, text, upHeaderId, discriminator];

  @override
  HeaderModel fromJson(Map<String, dynamic> json) => _$HeaderModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$HeaderModelToJson(this);

  HeaderModel copyWith({
    int? id,
    String? text,
    int? upHeaderId,
    String? discriminator,
  }) {
    return HeaderModel(
      id: id ?? this.id,
      discriminator: discriminator ?? this.discriminator,
      text: text ?? this.text,
      upHeaderId: upHeaderId ?? this.upHeaderId,
    );
  }
}
