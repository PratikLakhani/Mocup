import 'package:pkg_dio/pkg_dio.dart';
import 'package:plug2go/db/app_db.dart';
import 'package:plug2go/di/injector.dart';
import 'package:plug2go/extensions/ext_string_null.dart';
import 'package:plug2go/features/notifications/notification_page.dart';
import 'package:plug2go/features/notifications/provider/notification_provider.dart';
import 'package:plug2go/main.dart';
import 'package:plug2go/utils/app_navigations.dart';
import 'package:plug2go/utils/logger.dart';
import 'package:provider/provider.dart';

/// Custom Dio network interceptor for managing requests and responses globally
final class DioNetworkInterceptor extends Interceptor {
  /// constructor
  DioNetworkInterceptor({
    // required this.encryptor,
    // required this.deviceLocalUtils,
    required this.isSecure,
  });

  /// encrypt/decrypt utils class
  // final EncryptNetworkData encryptor;

  /// is secure network call or not (for token)
  final bool isSecure;

  /// AppDB
  late final appDB = Injector.instance<AppDB>();

  // late final langCubit = Injector.instance<AppLanguageCubit>();

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // options.headers['accept-language'] = appDB.userSettings?.language ?? 'en';
    // final connectivityResult = await Connectivity().checkConnectivity();
    // if (connectivityResult == ConnectivityResult.none) {
    //   return handler.reject(DioException(requestOptions: options, message: 'No internet connection!'));
    // }
    if (!appDB.isInternetConnected) {
      return handler.reject(
        DioException(
          requestOptions: options,
          // message: 'No internet connection! [${options.path}]',
          message: 'No internet connection!',
          type: DioExceptionType.connectionError,
          response: Response(statusCode: 412, requestOptions: options),
        ),
      );
    }
    // options.headers['device-country-code'] = await deviceLocalUtils.getDeviceLocalCode();
    final apiToken = isSecure ? ((options.headers['Authorization'] as String?) ?? appDB.token) : '';
    if (apiToken.isNotEmptyAndNotNull) {
      options.headers['Authorization'] = 'Bearer $apiToken';
    } else {
      // options.headers['Authorization'] = '';
    }
    options.headers['Accept'] = 'application/json';
    return handler.next(options);
  }

  // @override
  // Future<void> onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) async {
  //
  //   return handler.next(response);
  // }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    err.stackTrace.logE;
    // 'req data:${err.requestOptions.data}'.logV;
    // Injector.instance<CrashlyticsManager>().logHandledDartError(error: err, stackTrace: err.stackTrace);
    // err.response.logE;
    // err.response?.statusCode.logD;
    // err.type.logE;
    // err.stackTrace.logE;
    if (err.response?.statusCode?.clamp(500, 599) == err.response?.statusCode) {
      // final message = err.response?.statusMessage;
      // if (message.isNotEmptyAndNotNull) Alert.instance.showMessage(message!);
      err.response?.data = <String, dynamic>{};
      err.response?.statusMessage = 'Oops, something went wrong. Please try again';
      // err.response?.statusMessage = 'Oops, something went wrong. Please try again [${err.requestOptions.path}]';
    }
    // err.response?.toString().logE;
    if (err.response?.statusCode == 401) {
      appDB
        // ..userModel = null
        ..isEvUser = true;

      rootNavKey.currentContext!.read<NotificationProvider>().resetProvider();
      appDB.logoutUser().then((_) {
        AppNavigations.pushAndRemoveAllScreen(rootNavKey.currentContext!, const NotificationPage());
      });
      return;
    }
    if (err.type != DioExceptionType.cancel) handler.next(err);
  }
}
