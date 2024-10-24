import 'package:json_annotation/json_annotation.dart';

part 'notification_list_model.g.dart';

@JsonSerializable()
class NotificationListModel {
  NotificationListModel({
    this.status,
    this.response,
  });

  factory NotificationListModel.fromJson(Map<String, dynamic> json) => _$NotificationListModelFromJson(json);
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'response')
  List<Response>? response;

  NotificationListModel copyWith({
    int? status,
    List<Response>? response,
  }) =>
      NotificationListModel(
        status: status ?? this.status,
        response: response ?? this.response,
      );

  Map<String, dynamic> toJson() => _$NotificationListModelToJson(this);
}

@JsonSerializable()
class Response {
  Response({
    this.id,
    this.userId,
    this.type,
    this.title,
    this.description,
    this.typeId,
    this.isRead,
    this.requestStatus,
    this.startTime,
    this.createdAt,
    this.updatedAt,
  });

  factory Response.fromJson(Map<String, dynamic> json) => _$ResponseFromJson(json);
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'type_id')
  int? typeId;
  @JsonKey(name: 'is_read')
  int? isRead;
  @JsonKey(name: 'request_status')
  String? requestStatus;
  @JsonKey(name: 'start_time')
  DateTime? startTime;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  dynamic updatedAt;

  Response copyWith({
    int? id,
    int? userId,
    String? type,
    String? title,
    String? description,
    int? typeId,
    int? isRead,
    String? requestStatus,
    DateTime? startTime,
    DateTime? createdAt,
    dynamic updatedAt,
  }) =>
      Response(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        type: type ?? this.type,
        title: title ?? this.title,
        description: description ?? this.description,
        typeId: typeId ?? this.typeId,
        isRead: isRead ?? this.isRead,
        requestStatus: requestStatus ?? this.requestStatus,
        startTime: startTime ?? this.startTime,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  Map<String, dynamic> toJson() => _$ResponseToJson(this);
}
