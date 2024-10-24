import 'package:freezed_annotation/freezed_annotation.dart';

/// Converter to handle both String and int for JSON
class StringIntConverter implements JsonConverter<int, dynamic> {
  /// Default constructor
  const StringIntConverter();

  @override
  int fromJson(dynamic json) {
    if (json is int) {
      return json; // Already a String, return as-is
    } else if (json is String) {
      return double.parse(json).toInt(); // Convert String to int
    }
    return -1; // Return -1 if null or unsupported type
  }

  @override
  dynamic toJson(int object) {
    return object.toString(); // Attempt to parse to int, fallback to String
  }
}
