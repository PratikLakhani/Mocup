import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plug2go/shared/converter/double_to_string.dart';
import 'package:plug2go/shared/converter/string_to_int.dart';
import 'package:plug2go/shared/models/user_model/host_model.dart';

part 'charging_station.g.dart';

@JsonSerializable()
class NearbyStationResponse {
  NearbyStationResponse({
    required this.status,
    required this.msg,
    required this.acceptedRequest,
    required this.pendingRequests,
    required this.chargingStations,
  });

  factory NearbyStationResponse.fromJson(Map<String, dynamic> json) => _$NearbyStationResponseFromJson(json);

  @JsonKey(name: 'status')
  int status;
  @JsonKey(name: 'msg')
  String? msg;
  @JsonKey(name: 'accepted_request')
  Request? acceptedRequest;
  @JsonKey(name: 'pending_requests')
  @Default([])
  List<Request>? pendingRequests;
  @JsonKey(name: 'charging_stations')
  List<ChargingStation> chargingStations;

  Map<String, dynamic> toJson() => _$NearbyStationResponseToJson(this);
}

@JsonSerializable()
class ChargingStation {
  ChargingStation({
    required this.id,
    required this.hostId,
    required this.name,
    required this.connectorType,
    required this.chargingType,
    required this.hostType,
    required this.status,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.ratePerSession,
    required this.createdAt,
    required this.updatedAt,
    required this.distance,
    required this.host,
  });

  factory ChargingStation.fromJson(Map<String, dynamic> json) => _$ChargingStationFromJson(json);
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'host_id')
  int hostId;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'connector_type')
  String connectorType;
  @JsonKey(name: 'charging_type')
  String chargingType;
  @JsonKey(name: 'host_type')
  String hostType;
  @JsonKey(name: 'status')
  String status;
  @JsonKey(name: 'address')
  String address;
  @JsonKey(name: 'latitude')
  @DoubleStringConverter()
  String latitude;
  @DoubleStringConverter()
  @JsonKey(name: 'longitude')
  String longitude;
  @JsonKey(name: 'rate_per_session')
  String ratePerSession;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;
  @JsonKey(name: 'distance')
  double? distance;
  @JsonKey(name: 'host')
  HostModel? host;

  Map<String, dynamic> toJson() => _$ChargingStationToJson(this);
}

@JsonSerializable()
class Request {
  Request({
    required this.id,
    required this.userId,
    required this.hostUserId,
    required this.stationId,
    required this.status,
    required this.startTime,
    required this.endTime,
    required this.totalTime,
    required this.rate,
    required this.totalCost,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Request.fromJson(Map<String, dynamic> json) => _$RequestFromJson(json);
  @JsonKey(name: 'id')
  @StringIntConverter()
  int id;
  @JsonKey(name: 'user_id')
  @StringIntConverter()
  int userId;
  @JsonKey(name: 'host_user_id')
  @StringIntConverter()
  int hostUserId;
  @JsonKey(name: 'station_id')
  @StringIntConverter()
  int stationId;
  @JsonKey(name: 'status')
  String status;
  @JsonKey(name: 'start_time')
  DateTime? startTime;
  @JsonKey(name: 'end_time')
  DateTime? endTime;
  @JsonKey(name: 'total_time')
  double? totalTime;
  @JsonKey(name: 'rate')
  String rate;
  @JsonKey(name: 'total_cost')
  double? totalCost;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  Request copyWith({
    int? id,
    int? userId,
    int? hostUserId,
    int? stationId,
    String? status,
    DateTime? startTime,
    DateTime? endTime,
    double? totalTime,
    String? rate,
    double? totalCost,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Request(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        hostUserId: hostUserId ?? this.hostUserId,
        stationId: stationId ?? this.stationId,
        status: status ?? this.status,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        totalTime: totalTime ?? this.totalTime,
        rate: rate ?? this.rate,
        totalCost: totalCost ?? this.totalCost,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  Map<String, dynamic> toJson() => _$RequestToJson(this);
}
