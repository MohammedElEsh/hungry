import 'package:flutter/foundation.dart';

/// General helper utilities.
abstract class Helpers {
  /// Debounce function execution.
  static void debounce(VoidCallback action, {int milliseconds = 300}) {
    Future.delayed(Duration(milliseconds: milliseconds), action);
  }

  /// Check if string is valid non-empty.
  static bool isNotNullOrEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  /// Parse int safely.
  static int? parseInt(String? value) {
    if (value == null) return null;
    return int.tryParse(value);
  }

  /// Parse double safely.
  static double? parseDouble(String? value) {
    if (value == null) return null;
    return double.tryParse(value);
  }
}
