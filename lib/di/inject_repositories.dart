import 'package:flutter/foundation.dart' show immutable;
import 'package:get_it/get_it.dart';
import 'package:plug2go/di/injector.dart';
import 'package:plug2go/shared/repositories/notification_repository.dart';

/// Use Case injection
@immutable
class RepositoryInjector {
  /// Construct
  RepositoryInjector(this.instance) {
    _init();
  }

  /// GetIt instance
  final GetIt instance;

  void _init() {
    Injector.instance
      ..registerFactory(() => NotificationRepository(dio: instance()));
  }
}
