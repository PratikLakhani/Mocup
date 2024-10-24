// ignore_for_file: avoid_bool_literals_in_conditional_expressions

import 'dart:convert';

class ChatNotificationModel {
  ChatNotificationModel({
    this.messageData,
    this.receiverConnectionId,
    this.type,
    this.senderData,
    this.subscriptionStatus,
  });

  factory ChatNotificationModel.fromJson(Map<String, dynamic> json) {
    return ChatNotificationModel(
      messageData: json['message_data'] == null
          ? null
          : MessageData.fromJson(
              jsonDecode(json['message_data'].toString())
                  as Map<String, dynamic>,
            ),
      subscriptionStatus: json['subscription_status'] == null
          ? false
          : bool.parse(json['subscription_status'].toString().toLowerCase()),
      receiverConnectionId: json['receiver_connection_id'] == null
          ? -1
          : int.parse(json['receiver_connection_id'].toString()),
      type: json['type'] == null ? '' : json['type'].toString(),
      senderData: json['sender_data'] == null
          ? null
          : SenderData.fromJson(
              jsonDecode(json['sender_data'].toString())
                  as Map<String, dynamic>,
            ),
    );
  }

  final MessageData? messageData;
  final int? receiverConnectionId;
  final bool? subscriptionStatus;
  final String? type;
  final SenderData? senderData;

  Map<String, dynamic> toJson() => {
        'message_data': messageData?.toJson(),
        'receiver_connection_id': receiverConnectionId,
        'type': type,
        'sender_data': senderData?.toJson(),
      };
}

class MessageData {
  MessageData({
    this.id,
    this.senderConnectionId,
    this.createdAt,
    this.text,
    this.isRead,
    this.readTime,
    this.type,
    this.createdBy,
  });

  factory MessageData.fromJson(Map<String, dynamic> json) {
    return MessageData(
      id: json['id'] == null ? -1 : int.parse(json['id'].toString()),
      senderConnectionId: json['sender_connection_id'] == null
          ? -1
          : int.parse(json['sender_connection_id'].toString()),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.tryParse(json['created_at'].toString())?.toLocal(),
      text: json['text'] == null ? '' : json['text'].toString(),
      isRead: json['is_read'] == null
          ? false
          : bool.parse(json['is_read'].toString()),
      readTime: json['read_time'] == null
          ? null
          : DateTime.tryParse(json['read_time'].toString())?.toLocal(),
      type: json['type'] == null ? '' : json['type'].toString(),
      createdBy: json['created_by'] == null
          ? -1
          : int.parse(json['created_by'].toString()),
    );
  }

  final int? id;
  final int? senderConnectionId;
  final DateTime? createdAt;
  final String? text;
  final bool? isRead;
  final DateTime? readTime;
  final String? type;
  final int? createdBy;

  Map<String, dynamic> toJson() => {
        'id': id,
        'sender_connection_id': senderConnectionId,
        'created_at': createdAt?.toIso8601String(),
        'text': text,
        'is_read': isRead,
        'read_time': readTime,
        'type': type,
        'created_by': createdBy,
      };
}

class SenderData {
  SenderData({
    this.id,
    this.firstName,
    this.lastName,
    this.profileUrl,
  });

  factory SenderData.fromJson(Map<String, dynamic> json) {
    return SenderData(
      id: json['id'] == null ? -1 : int.parse(json['id'].toString()),
      firstName:
          json['first_name'] == null ? '' : json['first_name'].toString(),
      lastName: json['last_name'] == null ? '' : json['last_name'].toString(),
      profileUrl:
          json['profile_url'] == null ? '' : json['profile_url'].toString(),
    );
  }

  final int? id;
  final String? firstName;
  final String? lastName;
  final String? profileUrl;

  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'profile_url': profileUrl,
      };
}
