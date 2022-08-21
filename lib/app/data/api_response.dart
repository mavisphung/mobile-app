import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

import './errors/api_error.dart';

abstract class ApiResponse {
  static T? getResponse<T>(Response<T> response) {
    final status = response.status;

    if (status.connectionError) {
      throw ApiError(
        type: ErrorType.noConnection,
        error: 'no_con_msg'.tr,
      );
    }

    if (response.bodyString == null) throw const ApiError();

    try {
      final res = jsonDecode(response.bodyString!);

      print(
          'STATUS CODE: ${response.statusCode}, ${res["success"]}, ${res["status"]}');
      if (response.isOk) {
        if (res['success'] == true &&
            (res['status'] == 201 || res['status'] == 200)) {
          print('OK: ${response.body}');
          return response.body;
        }
      } else {
        if (res['success'] == false && res['status'] == 400) {
          if (res['message'].toString() == 'INVALID_INPUT' &&
              !res['data']['user'][0].toString().contains('does not exist')) {
            throw const ApiError(
              type: ErrorType.failedResponse,
              error: 'Invalid Input',
            );
          }
          print('NOT OK: ${response.body}');
          return response.body;
        } else if (status.isServerError) {
          print('SERVER ERROR');
          throw const ApiError();
        } else if (status.code == HttpStatus.requestTimeout) {
          throw const ApiError(
            type: ErrorType.connectTimeout,
            error: 'HttpStatus Connect Timeout',
          );
        } else if (response.unauthorized) {
          throw ApiError(
            type: ErrorType.unauthorized,
            error: res['message']?.toString() ?? 'Unauthorized Error',
          );
        } else {
          throw ApiError(
            type: ErrorType.failedResponse,
            error: res['message']?.toString() ?? 'Failed Response Error',
          );
        }
      }
    } on FormatException {
      throw const ApiError(
        type: ErrorType.unknownError,
        error: 'Format Exception',
      );
    } on TimeoutException catch (e) {
      throw ApiError(
        type: ErrorType.connectTimeout,
        error: e.message?.toString() ?? 'Connection Timeout',
      );
    }
    return null;
  }
}
