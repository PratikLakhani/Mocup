import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show immutable, kDebugMode;
import 'package:get_it/get_it.dart';
import 'package:native_dio_adapter/native_dio_adapter.dart';

/// Api client injector
@immutable
class ApiClientsInjector {
  /// Constructor
  ApiClientsInjector({
    required this.injector,
    required this.baseUrl,
    required this.isSecure,
    this.interceptors,
    this.enableNativeAdapter = true,
  }) {
    _init();
  }

  /// instance of injector
  final GetIt injector;

  /// Base Url
  final String baseUrl;

  /// Custom network interceptor
  final List<Interceptor>? interceptors;

  /// for secure header with token
  final bool isSecure;

  /// Enable Native Adapter
  final bool enableNativeAdapter;

  late final _baseOptions = BaseOptions(
    baseUrl: baseUrl,
    contentType: Headers.jsonContentType,
    connectTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  );

  final _logger = LogInterceptor(requestBody: true, responseBody: true);

  late final _dioClient = Dio(_baseOptions);

  void _init() {
    /* _dioClient.httpClientAdapter = Http2Adapter(
      ConnectionManager(
        idleTimeout: const Duration(minutes: 3),

        /// Ignore bad certificate
        onClientCreate: (_, config) => config.onBadCertificate = (_) => true,
      ),
    );*/
    if (enableNativeAdapter) {
      _dioClient.httpClientAdapter = NativeAdapter();
    }
    if (isSecure) {
      injector.registerLazySingleton<Dio>(
        () {
          if (kDebugMode) interceptors?.add(_logger);
          if (interceptors != null) _dioClient.interceptors.addAll(interceptors!);
          return _dioClient;
        },
      );
    } else {
      injector.registerLazySingleton<Dio>(
        () {
          if (kDebugMode) interceptors?.add(_logger);
          if (interceptors != null) _dioClient.interceptors.addAll(interceptors!);
          return _dioClient;
        },
        instanceName: 'open',
      );
    }
  }
}
