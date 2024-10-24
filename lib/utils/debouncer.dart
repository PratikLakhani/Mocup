import 'dart:async';

import 'package:flutter/foundation.dart';

/// Debouncer class for stopping video at max timeline
class Debouncer {
  /// Default constructor
  Debouncer({required this.seconds, this.duration});

  /// time in seconds
  final int seconds;

  /// Timer class to set timer
  Timer? _timer;

  /// Is running process,
  bool _isRunning = false;

  /// Adds custom timer
  Duration? duration;

  /// call to set timer
  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(duration ?? Duration(seconds: seconds), action);
  }

  Future<void> runOnce(AsyncCallback action) async {
    if (_isRunning) return;
    _isRunning = true;
    await action();
    await Future.delayed(const Duration(milliseconds: 400), () {});
    _isRunning = false;
  }

  /// cancels timer
  void dispose() {
    _timer?.cancel();
  }
}
