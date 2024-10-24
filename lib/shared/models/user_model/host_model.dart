import 'package:freezed_annotation/freezed_annotation.dart';

part 'host_model.g.dart';
part 'host_model.freezed.dart';

@Freezed(map: FreezedMapOptions.none, when: FreezedWhenOptions.none, fromJson: true, toJson: true)
class HostModel with _$HostModel {
  const factory HostModel({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'email') required String email,
    @JsonKey(name: 'phone_number') required String phoneNumber,
  }) = _HostModel;

  factory HostModel.fromJson(Map<String, dynamic> json) => _$HostModelFromJson(json);
}
