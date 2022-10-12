import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';

import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/data/errors/api_error.dart';

abstract class ApiResponse {
  static T? getResponse<T>(Response<T> response) {
    final status = response.status;

    if (status.connectionError) {
      throw ApiError(
        type: ErrorType.noConnection,
        error: Strings.noConMsg.tr,
      );
    }

    if (response.bodyString == null) throw const ApiError();

    try {
      final res = jsonDecode(response.bodyString!);

      // print('STATUS CODE: ${response.statusCode}, ${res["success"]}, ${res["status"]}');
      if (response.isOk) {
        if (res['success'] == true) {
          // print('OK: ${response.body}');
          return response.body;
        }
      } else {
        // print('NOT OK: ${response.body}');
        if (res['success'] == false && res['status'] == 400) {
          return response.body;
        } else if (status.isServerError) {
          // print('SERVER ERROR');
          throw const ApiError();
        } else if (status.code == HttpStatus.requestTimeout) {
          throw ApiError(
            type: ErrorType.connectTimeout,
            error: Strings.conTimeOutMsg.tr,
          );
        } else if (response.unauthorized) {
          if (res['message'] == 'AUTHENTICATION_FAILED') {
            throw ApiError(
              type: ErrorType.unauthorized,
              error: res['message'],
            );
          }
          throw ApiError(
            type: ErrorType.unauthorized,
            error: Strings.unauthorizedErrMsg.tr,
          );
        } else {
          throw ApiError(
            type: ErrorType.failedResponse,
            error: Strings.systemErrMsg.tr,
          );
        }
      }
    } on FormatException {
      throw ApiError(
        type: ErrorType.unknownError,
        error: Strings.formatErrMsg.tr,
      );
    } on TimeoutException {
      throw ApiError(
        type: ErrorType.connectTimeout,
        error: Strings.conTimeOutMsg.tr,
      );
    }
    return null;
  }
}
