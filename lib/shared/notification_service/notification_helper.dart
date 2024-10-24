// ignore_for_file: unawaited_futures, strict_raw_type, lines_longer_than_80_chars, avoid_dynamic_calls, avoid_print, cascade_invocations
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:plug2go/extensions/ext_string_null.dart';
import 'package:plug2go/shared/notification_service/local_notifications_helper.dart';
import 'package:plug2go/utils/logger.dart';

// /// Global key for get the context
// GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// This is a Top-level function where it is used for handling background or
/// Terminated state notifications. This is optional if you don't use onBackgroundMessage stream
@pragma('vm:entry-point')
Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
}

/// This class is helper for initialize Notification with get permission of user,
/// To handle foreground/background/terminated state notification.
class NotificationHelper {
  /// initialize and setup the notification for device.
  static Future<void> initializeNotification() async {
    // Getting the instance of firebase messaging
    final messaging = FirebaseMessaging.instance;
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    // iniitialize local notification for foreground notification.
    await LocalNotificationHelper.localNotificationHelper.initialize();

    /// Request the notification permission to user,
    /// in Android 12 or below,by default Notification permission is granted.
    if (Platform.isIOS) {
      await messaging.requestPermission();
    }

    /// To send notification to specific device, we need specific device token.
    /// To get device token, we can use following method
    // print(await messaging.getToken());

    // we can also send notification using subscibe the topic.
    // await FirebaseMessaging.instance.subscribeToTopic("myTopic");
    /// To handle Foreground notification
    FirebaseMessaging.onMessage.listen((event) {
      // notificationOnTapHandler(remoteMessage: event);
      print('1 notification =====>>> fg:  ${event.data.entries}');
      if (event.notification != null) {
        print(
          '2 notification =====>>> fg:  ${event.notification?.toMap().entries}',
        );
        if (Platform.isAndroid) {
          print('3 notification =====>>> fg:  {event.data.entries}');
          LocalNotificationHelper.localNotificationHelper.showNotification(event);
        }
        final data = jsonDecode(
          event.data['message_data'].toString(),
        );
        log('messagedata     ===   $data');
        if (data.toString().contains('type')) {
          final type = data['type'];
          type.toString().logD;
        }
      }
    });

    /// To handle Background/terminated app notification (This is optional.)
    // FirebaseMessaging.onBackgroundMessage(
    //   _firebaseMessagingBackgroundHandler,
    // );
    // To handle the Notification Tap Event on Background.
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('notification =====>>> bg: $event');
      notificationOnTapHandler(remoteMessage: event);
      // final data = jsonDecode(
      //   event.data['data'].toString(),
      // );
      // if (data.toString().contains('type')) {
      //   if (data['type'].toString() == 'chat_message') {}
      // }
    });
    // To handle the Notification Tap Event on Terminated state.
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      print('notification =====>>> tg:  $event');
      notificationOnTapHandler(remoteMessage: event);
    });
    // } else {
    //   // here you can give a message to the user if user not granted the permission.
    //   log('User declined the permission');
    // }
  }

  static Future<void> notificationOnTapHandler({
    RemoteMessage? remoteMessage,
    NotificationResponse? localData,
    bool isLocal = false,
  }) async {
    if (isLocal == false) {
      if (remoteMessage != null) {
        'notification localdata ===>> $remoteMessage'.logD;
        if (remoteMessage.data.isNotEmpty) {

        } else {

        }
      }
    } else {
      if (localData != null) {
        'notification localdata ===>> ${jsonDecode(localData.payload!)}'.logV;
        if (localData.payload!.isNotEmptyAndNotNull) {

        }
        // if (!data.toString().contains('type') || data?['type'] != 'CHAT') {
        //   AppNavigations.nextScreen(
        //     rootNavKey.currentContext!,
        //     const NotificationScreen(),
        //   );
        // } else {
        //   if (data.toString().contains('type')) {
        //     if (data?['type'] == 'CHAT') {
        //       // ^ handle chat navigation
        //     }
        //   }
        // }
      } else {

      }
    }
  }
}
