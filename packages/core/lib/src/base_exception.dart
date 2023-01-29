class BaseException implements Exception {
  BaseException({this.message, this.originException, this.stackTrace});

  final Object? originException;

  final String? message;

  /// The stack trace which provides information to the user about the call
  /// sequence that triggered an exception
  final StackTrace? stackTrace;

  @override
  String toString() {
    String output = '[$runtimeType] $message';

    if (originException != null) {
      output += '\noriginException:\n$originException';
    }

    if (stackTrace != null) {
      output += '\n\n${stackTrace.toString()}';
    }

    return output;
  }
}
