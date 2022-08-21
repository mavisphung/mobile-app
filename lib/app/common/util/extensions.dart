import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/api_response.dart';
import '../../data/auth/api_auth_model.dart';
import '../../data/errors/api_error.dart';
import '../../routes/app_pages.dart';
import '../constants.dart';
import '../storage/storage.dart';
import './loading_dialog.dart';
import './utils.dart';

extension FutureExt<T> on Future<Response<T>> {
  Future<ResponseModel?> futureValue({
    Function(String? error)? onError,
    VoidCallback? retryFunction,
    bool showLoading = true,
  }) async {
    // final _interface = Get.find<ApiInterfaceController>();
    // _interface.error = null;
    if (showLoading) LoadingDialog.showLoadingDialog();

    return await timeout(
      Constants.timeout,
      onTimeout: () {
        LoadingDialog.closeLoadingDialog();

        throw ApiError(
          type: ErrorType.connectTimeout,
          error: 'con_time_out_msg'.tr,
        );
      },
    ).then((value) {
      LoadingDialog.closeLoadingDialog();

      final responseBody = ApiResponse.getResponse<T>(value);
      print('RESPONSE BODY: $responseBody');
      if (responseBody != null) {
        final responseModel =
            ResponseModel.fromJson(responseBody as Map<String, dynamic>);
        return responseModel;
      }
      // _interface.update();
    }).catchError((e) {
      LoadingDialog.closeLoadingDialog();

      if (e == null) return null;

      final errorMessage = e is ApiError ? e.message : e.toString();

      if (e is ApiError) {
        if (e.type == ErrorType.connectTimeout) {
          Utils.showBottomSnackbar(errorMessage);
        } else if (e.type == ErrorType.noConnection) {
          // _interface.error = e;

          // Get.defaultDialog(title: 'No connection', middleText: errorMessage);
          Utils.showAlertDialog(errorMessage);
          // _retry(_interface, retryFunction);
        } else if (e.type == ErrorType.unauthorized) {
          if (e.message == 'AUTHENTICATION_FAILED') {
            Utils.showBottomSnackbar('Wrong email or password');
            return null;
          }
          Storage.clearStorage();
          Get.offAllNamed(Routes.LOGIN);
          // change the ROUTE to the LOGIN or SPLASH screen so that the
          // user can login again on UnauthorizeError error
        } else if (onError == null) {
          // Utils.showDialog(
          //   errorMessage,
          //   onConfirm: () => Get.back(),
          // );
          Utils.showAlertDialog(errorMessage);
        }
      }

      if (onError != null) {
        onError(errorMessage);
      }

      printError(info: 'catchError: $e\nerrorMessage: $errorMessage');
    });
  }

  // void _retry(
  //   ApiInterfaceController _interface,
  //   VoidCallback retryFunction,
  // ) {
  //   _interface.retry = retryFunction;
  //   _interface.update();
  // }
}
