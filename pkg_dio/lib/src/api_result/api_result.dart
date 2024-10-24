import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pkg_dio/src/exceptions/api_exception.dart';

part 'api_result.freezed.dart';

/// Generic Api result
@freezed
class ApiResult<T> with _$ApiResult<T> {
  /// Success Result
  const factory ApiResult.success({required T data}) = _SuccessResult;

  /// Error Result
  const factory ApiResult.error({required ApiException exception}) = _ErrorResult;
}
