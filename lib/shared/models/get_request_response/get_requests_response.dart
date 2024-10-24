// To parse this JSON data, do
//
//     final getRequestsResponse = getRequestsResponseFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plug2go/shared/converter/double_to_string.dart';
import 'package:plug2go/shared/converter/string_to_int.dart';

part 'get_requests_response.freezed.dart';
part 'get_requests_response.g.dart';

@Freezed(
  makeCollectionsUnmodifiable: false,
  map: FreezedMapOptions.none,
  when: FreezedWhenOptions.none,
  fromJson: true,
  toJson: true,
)
class GetRequestsResponse with _$GetRequestsResponse {
  const factory GetRequestsResponse({
    @JsonKey(name: 'status') required int status,
    @JsonKey(name: 'msg') required String msg,
    @JsonKey(name: 'service_requests') required List<ServiceRequest> serviceRequests,
  }) = _GetRequestsResponse;

  factory GetRequestsResponse.fromJson(Map<String, dynamic> json) => _$GetRequestsResponseFromJson(json);
}

@Freezed(
  makeCollectionsUnmodifiable: false,
  map: FreezedMapOptions.none,
  when: FreezedWhenOptions.none,
  fromJson: true,
  toJson: true,
)
class ServiceRequest with _$ServiceRequest {
  const factory ServiceRequest({
    @JsonKey(name: 'id') @StringIntConverter() required int id,
    @JsonKey(name: 'user_id') @StringIntConverter() required int userId,
    @JsonKey(name: 'host_user_id') @StringIntConverter() required int hostUserId,
    @JsonKey(name: 'station_id') @StringIntConverter() required int stationId,
    @JsonKey(name: 'status') required String status,
    @JsonKey(name: 'start_time') required DateTime? startTime,
    @JsonKey(name: 'end_time') required DateTime? endTime,
    @JsonKey(name: 'total_time') required double? totalTime,
    @JsonKey(name: 'rate') required String rate,
    @JsonKey(name: 'total_cost') required String? totalCost,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'distance') @DoubleStringConverter() required String? distance,
    @JsonKey(name: 'user') required User? user,
    @JsonKey(name: 'station') required StationModel? station,
  }) = _ServiceRequest;

  factory ServiceRequest.fromJson(Map<String, dynamic> json) => _$ServiceRequestFromJson(json);
}

@Freezed(
  makeCollectionsUnmodifiable: false,
  map: FreezedMapOptions.none,
  when: FreezedWhenOptions.none,
  fromJson: true,
  toJson: true,
)
class User with _$User {
  const factory User({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'email') required String email,
    @JsonKey(name: 'phone_number') required String phoneNumber,
    @JsonKey(name: 'address') required String? address,
    @JsonKey(name: 'latitude') @DoubleStringConverter() required String? latitude,
    @JsonKey(name: 'longitude') @DoubleStringConverter() required String? longitude,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@Freezed(
  makeCollectionsUnmodifiable: false,
  map: FreezedMapOptions.none,
  when: FreezedWhenOptions.none,
  fromJson: true,
  toJson: true,
)
class StationModel with _$StationModel {
  const factory StationModel({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'connector_type') required String connectorType,
    @JsonKey(name: 'charging_type') required String chargingType,
    @JsonKey(name: 'latitude') required String latitude,
    @JsonKey(name: 'longitude') required String longitude,
  }) = _StationModel;

  factory StationModel.fromJson(Map<String, dynamic> json) => _$StationModelFromJson(json);
}
