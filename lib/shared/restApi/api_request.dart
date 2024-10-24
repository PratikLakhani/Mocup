import 'package:flutter/foundation.dart' show immutable;
import 'package:pkg_dio/pkg_dio.dart';

/// Common Api request data holder
@immutable
class ApiRequest {
  /// Constructor
  const ApiRequest({
    this.path,
    this.data,
    this.params,
    this.options,
    this.cancelToken,
    this.receiveProgress,
    this.hideKeyboard = true,
  });

  /// path parameter
  final String? path;

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

  /// hide keyboard
  final bool hideKeyboard;
}
