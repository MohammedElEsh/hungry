class ApiError {
  final String message;
  final int? statusCode;

  ApiError({required this.message, this.statusCode});

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      message: json['message'],
      statusCode: json['statusCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'statusCode': statusCode,
    };
  }

  @override
  String toString() {
    return 'ApiError{message: $message, statusCode: $statusCode}';
  }
}
