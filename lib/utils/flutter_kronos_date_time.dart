import 'dart:async';

import 'package:flutter_kronos_plus/flutter_kronos_plus.dart';

/// class to get central time
class FlutterKronosDateTime {
  /// Returns central time instance
  factory FlutterKronosDateTime.instance() => _instance;

  FlutterKronosDateTime._();

  static final FlutterKronosDateTime _instance = FlutterKronosDateTime._();

  /// initializes class
  void initialize() {
    FlutterKronosPlus.sync();
  }

  /// Checks if Central time is initialized or not
  Future<bool> isInitialized() async {
    return (await FlutterKronosPlus.getNtpDateTime != null);
  }

  /// provides current UTC
  Future<DateTime> utcNow() async {
    final dateTime = (await FlutterKronosPlus.getNtpDateTime)!.toUtc();
    // 'UTC ${dateTime.toIso8601String()}'.logI;
    return dateTime;
  }
}
