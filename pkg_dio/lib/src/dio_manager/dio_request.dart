// import 'dart:isolate';

// ignore_for_file: avoid_dynamic_calls

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show FocusManager, immutable;
import 'package:pkg_dio/pkg_dio.dart';
import 'package:pkg_dio/src/dio_manager/logger.dart';

/// generic json mapper
typedef JsonMapper<T> = T Function(Map<String, dynamic>);

/// generic list json mapper
typedef ListJsonMapper<T> = T Function(List<dynamic>);

/// Request model for APIs
@immutable
class DioRequest<T> {
  /// DIO Request
  const DioRequest({
    required this.dio,
    required this.path,
    this.jsonMapper,
    this.listJsonMapper,
    this.data,
    this.params,
    this.options,
    this.cancelToken,
    this.receiveProgress,
    this.hideKeyboard = true,
  })  : assert(jsonMapper != null || listJsonMapper != null, 'Provide at least one json mapper!'),
        assert(jsonMapper == null || listJsonMapper == null, 'Can not provide both json mapper!');

  /// Dio instance
  final Dio dio;

  /// endpoint
  final String path;

  /// body data
  final Object? data;

  /// parameters
  final Map<String, dynamic>? params;

  /// Dio options
  final Options? options;

  /// cancel token
  final CancelToken? cancelToken;

  /// receive progress callback
  final ProgressCallback? receiveProgress;

  /// Use this for if response is JsonObject
  final JsonMapper<T>? jsonMapper;

  /// Use this for if response is JsonArray
  final ListJsonMapper<T>? listJsonMapper;

  /// close keyboard
  final bool hideKeyboard;

  /// GET method
  Future<ApiResult<T>> get() => _requestCall('GET');

  /// POST method
  Future<ApiResult<T>> post() => _requestCall('POST');

  /// PUT method
  Future<ApiResult<T>> put() => _requestCall('PUT');

  /// PATCH method
  Future<ApiResult<T>> patch() => _requestCall('PATCH');

  /// DELETE method
  Future<ApiResult<T>> delete() => _requestCall('DELETE');

  Future<ApiResult<T>> _requestCall(String method) async {
    if (kDebugMode) {
      '\x1B[6m\x1B[32m path ==>  $path \x1B[0m'.logI;
      '\x1B[6m\x1B[32m data ==>  $data \x1B[0m'.logI;
      '\x1B[6m\x1B[32m params ==>  $params \x1B[0m'.logI;
      '\x1B[6m\x1B[32m option ==>  ${options?.headers?.entries} \x1B[0m'.logI;
    }
    if (hideKeyboard) FocusManager.instance.primaryFocus?.unfocus();
    try {
      if (cancelToken?.isCancelled ?? false) {
        return const ApiResult.error(exception: ApiException(code: -1, message: 'Request Cancelled'));
      }
      final response = await dio.request<dynamic>(
        path,
        options: (options ?? Options())..method = method,
        queryParameters: params,
        data: data,
        cancelToken: cancelToken,
        onReceiveProgress: receiveProgress,
      );
      'Api response ==>  ${response.data}'.logI;
      /*final response = await Isolate.run(
        () {
          return dio.request<dynamic>(
            path,
            options: (options ?? Options())..method = method,
            queryParameters: params,
            data: data,
            cancelToken: cancelToken,
            onReceiveProgress: receiveProgress,
          );
        },
      );*/
      return _responseHandler(response);
    } on DioException catch (ex) {
      // Logger().e(ex.type);
      // Logger().e(ex.message);
      // Logger().e(ex.response?.statusCode);
      // 'path $path'.logFatal;
      // 'data $data'.logFatal;
      // '${ex.response?.statusCode}'.logFatal;
      // '${ex.response?.data}'.logFatal;
      // '${ex.error}'.logFatal;

      return ApiResult.error(exception: ex.toApiException);
    } on Exception catch (ex) {
      return ApiResult.error(exception: ApiException(code: -1, message: ex.toString()));
    }
  }

  Future<ApiResult<T>> _responseHandler(Response<dynamic> response) async {
    if (response.data != null) {
      /// for any direct response
      /*if (T != ApiResponse) {
        if (response.statusCode?.clamp(200, 299) == response.statusCode) {
          // final data = await compute(jsonMapper!, response.data as Map<String, dynamic>);
          final data = jsonMapper!(response.data as Map<String, dynamic>);
          return ApiResult.success(data: data);
        } else {
          return ApiResult.error(
            exception: ApiException(
              code: response.statusCode ?? -1,
              message: response.statusMessage ?? 'Status message not found!',
            ),
          );
        }
      }*/
      // final apiResponse = ApiResponse.fromJson(response.data as Map<String, dynamic>);
      final apiResponse = ApiResponse.fromJson({
        'code': response.statusCode ?? -1,
        'data': response.data,
        'message': (response.data is Map<String, dynamic> && (response.data as Map<String, dynamic>).containsKey('msg'))
            ? (response.data as Map<String, dynamic>)['msg']
            : response.statusMessage ?? 'Status message not found!',
      });

      // final apiResponse = await compute(, response.data as Map<String, dynamic>);
      // final apiResponse = await Isolate.run(() => ApiResponse.fromJson(response.data as Map<String, dynamic>));
      if (apiResponse.code.clamp(200, 299) != apiResponse.code) {
        return ApiResult.error(exception: ApiException(code: apiResponse.code, message: apiResponse.message));
      }
      // Logger().d('T runTimeType : $T  ${T.runtimeType} ---> ${T == ApiResponse}');
      if (T == ApiResponse && ((response.data as Map<String, dynamic>?)?.isNotEmpty ?? false)) {
        // final data = jsonMapper!.call(response.data as Map<String, dynamic>);
        final data = await compute(jsonMapper!, response.data as Map<String, dynamic>);
        // final data = await Isolate.run(() => jsonMapper!.call(response.data as Map<String, dynamic>));
        return ApiResult.success(data: data);
      } else if (apiResponse.data is Map<String, dynamic> && jsonMapper != null) {
        // final data = jsonMapper!.call(apiResponse.data as Map<String, dynamic>);
        final data = await compute(jsonMapper!, apiResponse.data as Map<String, dynamic>);
        // final data = await Isolate.run(() => jsonMapper!.call(apiResponse.data as Map<String, dynamic>));
        return ApiResult.success(data: data);
      } else if (apiResponse.data is List<dynamic> && listJsonMapper != null) {
        // final data = listJsonMapper!.call(apiResponse.data as List<dynamic>);
        final data = await compute(listJsonMapper!, apiResponse.data as List<dynamic>);
        // final data = await Isolate.run(() => listJsonMapper!.call(apiResponse.data as List<dynamic>));
        return ApiResult.success(data: data);
      } else {
        return ApiResult.error(
          exception: ApiException(code: response.statusCode ?? -1, message: 'No jsonMapper provided'),
        );
      }
    } else {
      return ApiResult.error(
        exception: ApiException(code: response.statusCode ?? -1, message: 'Response not found!'),
      );
    }
  }
}
