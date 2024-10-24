// To parse this JSON data, do
//
//     final notificationCountModel = notificationCountModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';

part 'notification_count_model.g.dart';

@JsonSerializable()
class NotificationCountModel {
  NotificationCountModel({
    this.status,
    this.response,
  });

  factory NotificationCountModel.fromJson(Map<String, dynamic> json) => _$NotificationCountModelFromJson(json);
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'response')
  Response? response;

  NotificationCountModel copyWith({
    int? status,
    Response? response,
  }) =>
      NotificationCountModel(
        status: status ?? this.status,
        response: response ?? this.response,
      );

  Map<String, dynamic> toJson() => _$NotificationCountModelToJson(this);
}

@JsonSerializable()
class Response {
  Response({
    this.count,
  });

  factory Response.fromJson(Map<String, dynamic> json) => _$ResponseFromJson(json);
  @JsonKey(name: 'count')
  int? count;

  Response copyWith({
    int? count,
  }) =>
      Response(
        count: count ?? this.count,
      );

  Map<String, dynamic> toJson() => _$ResponseToJson(this);
}
