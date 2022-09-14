import 'dart:developer';

/// {@template AppLogger}
/// App logger is a helper used to log message with formatted message and color
/// {@endtemplate}
class AppLogger {
  /// {@macro log error message}
  static void e(String message, [dynamic error, StackTrace? stackTrace]) {
    log(message, error: error, stackTrace: stackTrace);
  }

  /// {@macro log error success message}
  static void s(String message, [dynamic error, StackTrace? stackTrace]) {
    log(message, error: error, stackTrace: stackTrace);
  }
}
