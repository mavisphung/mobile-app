import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/api_response.dart';
import '../../data/auth/api_auth_model.dart';
import '../../data/errors/api_error.dart';
import '../../routes/app_pages.dart';
import '../constants.dart';
import '../storage/storage.dart';
import '../values/strings.dart';
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
          error: Strings.conTimeOutMsg.tr,
        );
      },
    ).then((value) {
      LoadingDialog.closeLoadingDialog();

      final responseBody = ApiResponse.getResponse<T>(value);
      print('RESPONSE BODY: $responseBody');
      if (responseBody != null) {
        final responseModel = ResponseModel.fromJson(responseBody as Map<String, dynamic>);
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
            Utils.showBottomSnackbar(Strings.loginFailedMsg.tr);
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

enum Gender { male, female, other }

extension GenderExt on Gender {
  String get value {
    switch (this) {
      case Gender.male:
        return 'MALE';
      case Gender.female:
        return 'FEMALE';
      default:
        return 'OTHER';
    }
  }
}

enum AppointmentType { all, online, offline }

extension AppointmentTypeExt on AppointmentType {
  String get value {
    switch (this) {
      case AppointmentType.online:
        return 'ONLINE';
      case AppointmentType.offline:
        return 'OFFLINE';
      default:
        return 'ALL';
    }
  }
}

extension AppointmentTypeExt2 on AppointmentType {
  String get label {
    switch (this) {
      case AppointmentType.online:
        return 'Online';
      case AppointmentType.offline:
        return 'Offline';
      default:
        return 'all';
    }
  }
}

enum AppointmentStatus { all, pending, completed, cancelled, inProgress }

extension AppointmentStatusExt on AppointmentStatus {
  String get value {
    switch (this) {
      case AppointmentStatus.pending:
        return 'PENDING';
      case AppointmentStatus.completed:
        return 'COMPLETED';
      case AppointmentStatus.cancelled:
        return 'CANCELLED';
      case AppointmentStatus.inProgress:
        return 'IN_PROGRESS';
      default:
        return 'ALL';
    }
  }
}

extension AppointmentStatusExt2 on AppointmentStatus {
  String get label {
    switch (this) {
      case AppointmentStatus.pending:
        return 'Pending';
      case AppointmentStatus.completed:
        return 'Completed';
      case AppointmentStatus.cancelled:
        return 'Cancelled';
      case AppointmentStatus.inProgress:
        return 'In Progress';
      default:
        return 'All';
    }
  }
}
