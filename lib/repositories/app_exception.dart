class AppException implements Exception {

  final int code;
  final String message;

  AppException(this.message, {this.code});

  String getMessage() {
    return message;
  }

}