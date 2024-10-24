import 'package:flutter/foundation.dart' show immutable;
import 'package:get_it/get_it.dart';
import 'package:pkg_dio/pkg_dio.dart';
import 'package:plug2go/app/dio_network_interceptor.dart';
import 'package:plug2go/di/inject_repositories.dart';
import 'package:plug2go/di/inject_services.dart';
import 'package:plug2go/shared/restApi/endpoints.dart';

/// App Dependencies Injection using GetIt
@immutable
class Injector {
  const Injector._();

  static final _injector = GetIt.instance;

  /// GetIt Instance
  static GetIt get instance => _injector;

  /// init all dependencies module wise
  static void initModules() {

    ServicesInjector(instance);

    /// use instanceName: 'open' for open api client
    ApiClientsInjector(
      injector: instance,
      baseUrl: EndPoints.baseUrl,
      isSecure: false,
      interceptors: <Interceptor>[DioNetworkInterceptor(isSecure: false)],
      // enableNativeAdapter: true,
    );
    ApiClientsInjector(
      injector: instance,
      baseUrl: EndPoints.baseUrl,
      isSecure: true,
      interceptors: <Interceptor>[DioNetworkInterceptor(isSecure: true)],
      // enableNativeAdapter: true,
    );
    RepositoryInjector(instance);
  }
}
