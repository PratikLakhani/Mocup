import 'package:pkg_dio/pkg_dio.dart';
import 'package:plug2go/features/notifications/model/notification_count_model.dart';
import 'package:plug2go/features/notifications/model/notification_list_model.dart';
import 'package:plug2go/shared/restApi/api_request.dart';
import 'package:plug2go/shared/restApi/endpoints.dart';

/// Dio requests for all the notification apis
final class NotificationRepository {
  /// construction call
  const NotificationRepository({required this.dio});

  /// define dio variable
  final Dio dio;

  ///Api call fetch notification list.
  Future<ApiResult<NotificationListModel>> getNotifications(ApiRequest request) {
    return DioRequest<NotificationListModel>(
      dio: dio,
      path: request.path ?? EndPoints.notificationList,
      jsonMapper: NotificationListModel.fromJson,
      cancelToken: request.cancelToken,
      hideKeyboard: request.hideKeyboard,
      data: request.data,
      options: request.options,
      params: request.params,
      receiveProgress: request.receiveProgress,
    ).get();
  }

  ///Api call fetch notification count.
  Future<ApiResult<NotificationCountModel>> getNotificationsCount(ApiRequest request) {
    return DioRequest<NotificationCountModel>(
      dio: dio,
      path: request.path ?? EndPoints.getNotificationCount,
      jsonMapper: NotificationCountModel.fromJson,
      cancelToken: request.cancelToken,
      hideKeyboard: request.hideKeyboard,
      data: request.data,
      options: request.options,
      params: request.params,
      receiveProgress: request.receiveProgress,
    ).get();
  }
}
