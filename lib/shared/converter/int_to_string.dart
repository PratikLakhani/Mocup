import 'package:freezed_annotation/freezed_annotation.dart';

/// Converter to handle both int and String for JSON
class IntStringConverter implements JsonConverter<String, dynamic> {
  /// Default constructor
  const IntStringConverter();

  @override
  String fromJson(dynamic json) {
    if (json is int) {
      return json.toString(); // Convert int to String
    } else if (json is String) {
      return json; // Already a String, return as-is
    }
    return ''; // Return empty string if null or unsupported type
  }

  @override
  dynamic toJson(String object) {
    return int.tryParse(object) ?? object; // Attempt to parse to int, fallback to String
  }
}
