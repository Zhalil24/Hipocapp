import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
part 'base_response_model.g.dart';

@JsonSerializable()
class BaseResponseModel extends INetworkModel<BaseResponseModel> with EquatableMixin {
  final bool? isSuccess;
  final dynamic data; // 🔥 `Map<String, dynamic>` yerine `dynamic` olarak bırak
  final String? message;

  BaseResponseModel({this.isSuccess, this.data, this.message});

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) {
    return BaseResponseModel(
      isSuccess: json["isSuccess"] as bool?,
      data: json["data"], // 🔥 Burada `Map<String, dynamic>.from` kullanma!
      message: json["message"] as String?,
    );
  }

  @override
  BaseResponseModel fromJson(Map<String, dynamic> json) => BaseResponseModel.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "data": data, // 🔥 Burayı direkt ekle
        "message": message,
      };

  @override
  List<Object?> get props => [isSuccess, data, message];
}
