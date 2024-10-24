import 'package:json_annotation/json_annotation.dart';
part 'message_model.g.dart';

@JsonSerializable()
class MessageModel {
  MessageModel({
    required this.message,
    required this.sentBy,
    required this.sessionId,
    required this.timestamp,
    required this.read,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);

  @JsonKey(name: 'message')
  String message;
  @JsonKey(name: 'sent_by')
  int sentBy;
  @JsonKey(name: 'session_id')
  int sessionId;
  @JsonKey(name: 'timestamp')
  String timestamp;
  @JsonKey(name: 'read')
  bool read;

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
