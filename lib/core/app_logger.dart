import 'dart:developer';

class AppLogger {
  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    log(message, error: error, stackTrace: stackTrace);
  }

  static void s(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    log(message, error: error, stackTrace: stackTrace);
  }
}
