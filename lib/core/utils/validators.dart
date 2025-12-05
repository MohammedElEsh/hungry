class Validators {
  /// ✅ Check if valid email format
  static String? email(
    String? value, {
    String message = 'Enter a valid email',
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final regex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value.trim())) {
      return message;
    }
    return null;
  }

  /// ✅ Check password rules (required + min length)
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
