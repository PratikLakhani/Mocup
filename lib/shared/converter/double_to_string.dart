import 'package:freezed_annotation/freezed_annotation.dart';

class DoubleStringConverter implements JsonConverter<String, dynamic> {
  /// Default constructor
  const DoubleStringConverter();

  @override
  String fromJson(dynamic json) {
    if (json is num) {
      return json.toString(); // Convert double to String
    } else if (json is String) {
      return json; // Already a String, return as-is
    }
    return ''; // Return empty string if null or unsupported type
  }

  @override
  dynamic toJson(String object) {
    return double.tryParse(object) ?? object; // Attempt to parse to double, fallback to String
  }
}
