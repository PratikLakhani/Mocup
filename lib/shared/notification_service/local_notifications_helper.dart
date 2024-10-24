import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:plug2go/shared/notification_service/notification_helper.dart';

class LocalNotificationHelper {
  LocalNotificationHelper._();
    static final localNotificationHelper = LocalNotificationHelper._();
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'default_channel',
    'Default Channel',
    importance: Importance.high,
  );

  static const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  static const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings();

  static AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    channel.id,
    channel.name,
    visibility: NotificationVisibility.public,
    importance: Importance.high,
    enableLights: true,
  );

  static DarwinNotificationDetails darwinNotificationDetails =
      const DarwinNotificationDetails(presentSound: true);

   Future<void> initialize() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

        await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
      ),
      onDidReceiveNotificationResponse: (details) {
        if (details.payload != '') {
          NotificationHelper.notificationOnTapHandler(
            localData: details,
            isLocal: true,
          );
        }
      },
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

  }

   Future<void> showNotification(RemoteMessage remoteMessage) async {
    await flutterLocalNotificationsPlugin.show(
      remoteMessage.notification.hashCode,
      remoteMessage.notification?.title,
      remoteMessage.notification?.body,
      NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails,
      ),
      payload:
          remoteMessage.data.isNotEmpty ? jsonEncode(remoteMessage.data) : null,
    );
  }
}
