import 'package:flutter/foundation.dart' show immutable;
import 'package:get_it/get_it.dart';
import 'package:plug2go/db/app_db.dart';

/// Services injector
@immutable
class ServicesInjector {
  /// Constructor
  ServicesInjector(this.instance) {
    _init();
  }

  /// GetIt instance
  final GetIt instance;

  void _init() {
    instance
      ..allowReassignment = true
      ..registerSingletonAsync(AppDB.getInstance);
  }
}
