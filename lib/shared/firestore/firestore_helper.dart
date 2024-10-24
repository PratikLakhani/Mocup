import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plug2go/shared/models/message_model.dart';

class FirestoreHelper {
  static Stream<QuerySnapshot<Map<String, dynamic>>> getChatStream(
    String chatId,
    int sessionId,
  ) {
    return FirebaseFirestore.instance
        .collection(
          '${FirestoreCollections.chats}/$chatId/${FirestoreCollections.messages}',
        )
        .orderBy(FirestoreFields.timestamp, descending: true)
        .where(FirestoreFields.sessionId, isEqualTo: sessionId)
        .snapshots();
  }

  static Future<void> sendMessage(
    String chatId,
    Map<String, dynamic> message,
  ) async {
    await FirebaseFirestore.instance
        .collection(
          '${FirestoreCollections.chats}/$chatId/${FirestoreCollections.messages}',
        )
        .add(message);
  }

  static List<MessageModel> getMessagesAsList(
    List<QueryDocumentSnapshot> messages,
  ) {
    return messages.map((message) {
      return MessageModel.fromJson(
        (message.data() as Map<String, dynamic>?) ?? {},
      );
    }).toList();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getUnreadCount(
    String chatId,
    int sessionId,
  ) {
    return FirebaseFirestore.instance
        .collection(
          '${FirestoreCollections.chats}/$chatId/${FirestoreCollections.messages}',
        )
        .orderBy(FirestoreFields.timestamp, descending: true)
        .where(FirestoreFields.sessionId, isEqualTo: sessionId)
        .where(FirestoreFields.read, isEqualTo: false)
        .snapshots();
  }

  static Future<void> updateReadReceipt(String chatId, int sessionId) async {
    final msgs = await FirebaseFirestore.instance
        .collection(
          '${FirestoreCollections.chats}/$chatId/${FirestoreCollections.messages}',
        )
        .orderBy(FirestoreFields.timestamp, descending: true)
        .where(FirestoreFields.sessionId, isEqualTo: sessionId)
        .where(FirestoreFields.read, isEqualTo: false)
        .get();
    for (var i = 0; i < msgs.docs.length; i++) {
      unawaited(
        msgs.docs[i].reference
            .set({FirestoreFields.read: true}, SetOptions(merge: true)),
      );
    }
  }

  static String getChatIdFromUserIds(int otherUserId, int? myUserId) {
    if (otherUserId > (myUserId ?? 0)) {
      return '$otherUserId-$myUserId';
    } else {
      return '$myUserId-$otherUserId';
    }
  }
}

class FirestoreCollections {
  static const chats = 'chats';
  static const messages = 'messages';
}

class FirestoreFields {
  static const timestamp = 'timestamp';
  static const sessionId = 'session_id';
  static const read = 'read';
  static const sentBy = 'sent_by';
}
