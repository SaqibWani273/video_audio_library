class CustomException implements Exception {
  final ExceptionType type;
  final String message;

  CustomException({required this.message, required this.type});
}

enum ExceptionType {
  network,
  unknown,
}
