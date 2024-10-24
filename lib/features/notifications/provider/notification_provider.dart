import 'package:flutter/material.dart';
import 'package:pkg_dio/pkg_dio.dart';
import 'package:plug2go/db/app_db.dart';
import 'package:plug2go/di/injector.dart';
import 'package:plug2go/features/notifications/model/notification_list_model.dart';
import 'package:plug2go/shared/repositories/notification_repository.dart';
import 'package:plug2go/shared/restApi/api_request.dart';
import 'package:plug2go/shared/restApi/endpoints.dart';
import 'package:plug2go/utils/logger.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationProvider(this.notificationRepository) {
    scrollController.addListener(_scrollListener);
  }
  NotificationListModel? notificationListModel;

  ScrollController scrollController = ScrollController();

  NotificationRepository notificationRepository;

  CancelToken? cancelToken;

  bool isCallInProgress = false;

  bool hasMoreData = true;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  ValueNotifier<int> notificationCount = ValueNotifier(0);

  int limit = 10;

  void _scrollListener() {
    hasMoreData.logD;
    if (hasMoreData &&
        scrollController.position.pixels >= (scrollController.position.maxScrollExtent / 2) &&
        !isCallInProgress) {
      'event'.logD;
      getNotifications(isRefresh: false);
    }
  }

  Future<dynamic> getNotifications({required bool isRefresh}) async {
    if (!hasMoreData && isRefresh == false) {
      return;
    }
    isCallInProgress = true;
    if (isRefresh == false && notificationListModel == null) {
      _isLoading = true;
      notifyListeners();
    }
    try {
      cancelToken?.cancel();
      cancelToken = CancelToken();
      final notificationList = await notificationRepository.getNotifications(
        ApiRequest(
          path: EndPoints.notificationList,
          params: {
            'isHost': !Injector.instance<AppDB>().isEvUser,
            'limit': limit,
            'offset': isRefresh ? 0 : notificationListModel?.response?.length ?? 0,
          },
          cancelToken: cancelToken,
        ),
      );
      return notificationList.when(
        success: (data) {
          if (isRefresh || notificationListModel == null || isRefresh) {
            notificationListModel = data;
          } else {
            notificationListModel?.response?.addAll(data.response ?? []);
          }
          if ((data.response?.length ?? 0) < limit) {
            hasMoreData = false;
          } else {
            hasMoreData = true;
          }

          _isLoading = false;
          notifyListeners();
          data.logD;
          isCallInProgress = false;
          return data;
        },
        error: (exception) async {
          _isLoading = false;
          notifyListeners();
          exception.logD;
          isCallInProgress = false;
          return exception;
        },
      );
    } catch (e) {
      e.logFatal;
      _isLoading = false;
      isCallInProgress = false;
    }
    isCallInProgress = false;
  }

  Future<dynamic> getNotificationCount() async {
    final vehicleList = await notificationRepository.getNotificationsCount(
      ApiRequest(
        path: EndPoints.getNotificationCount,
        params: {
          'isHost': !Injector.instance<AppDB>().isEvUser,
        },
      ),
    );
    return vehicleList.when(
      success: (data) {
        'data count $data'.logD;
        notificationCount.value = data.response?.count ?? 0;
        return data;
      },
      error: (exception) async {
        return exception;
      },
    );
  }

  void resetProvider() {
    notificationListModel = null;
    notificationCount.value = 0;
    hasMoreData = true;
    notifyListeners();
  }

  void resetNotification() {
    notificationListModel = null;
    hasMoreData = true;
    notifyListeners();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
