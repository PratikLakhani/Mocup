import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plug2go/shared/models/charging_station/charging_station.dart';

part 'update_charging_station.g.dart';

@JsonSerializable()
class UpdateChargingStationResponse {
  UpdateChargingStationResponse({
    required this.status,
    required this.msg,
    required this.chargingStation,
  });

  factory UpdateChargingStationResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateChargingStationResponseFromJson(json);

  @JsonKey(name: 'status') @Default(-1) int status;
  @JsonKey(name: 'msg') @Default('') String? msg;
  @JsonKey(name: 'charging_station')
  ChargingStation chargingStation;

  Map<String, dynamic> toJson() => _$UpdateChargingStationResponseToJson(this);
}
