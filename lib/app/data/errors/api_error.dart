import 'package:get/get.dart';

import '../../common/values/strings.dart';

enum ErrorType {
  // It occurs when the connection is timeout
  connectTimeout,

  // It occurs when there is no connection
  noConnection,

  // When the server response, but with a incorrect status, such as 404, 503...
  failedResponse,

  // When the request is cancelled
  cancelled,

  // When the request is unauthorized
  unauthorized,

  // Default error type, some other errors. In this case, we can
  // use the ApiError.error if it is not null
  unknownError,
}

// ApiError descibes the error info when request failed
class ApiError implements Exception {
  final ErrorType type;

  // The original error/exeption object
  final dynamic error;
  const ApiError({
    this.type = ErrorType.unknownError,
    this.error,
  });

  String get message => (error?.toString() ?? Strings.unknownErrMsg.tr);

  @override
  String toString() {
    final msg = 'Error ${type.name}: $message';
    return msg;
  }
}
