import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/api_response.dart';
import '../../data/errors/api_error.dart';
import '../../data/response_model.dart';
import '../../routes/app_pages.dart';
import '../constants.dart';
import '../storage/storage.dart';
import '../values/strings.dart';
import './utils.dart';

extension FutureExt<T> on Future<Response<T>> {
  Future<ResponseModel1?> futureValue({
    Function(String? error)? onError,
    VoidCallback? retryFunction,
  }) async {
    // final _interface = Get.find<ApiInterfaceController>();
    // _interface.error = null;

    return await timeout(
      Constants.timeout,
      onTimeout: () {
        throw ApiError(
          type: ErrorType.connectTimeout,
          error: Strings.conTimeOutMsg.tr,
        );
      },
    ).then((value) {
      final responseBody = ApiResponse.getResponse<T>(value);
      print('RESPONSE BODY: $responseBody');
      if (responseBody != null) {
        final responseModel1 = ResponseModel1.fromJson(responseBody as Map<String, dynamic>);
        return responseModel1;
      }
      // _interface.update();
    }).catchError((e) {
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

enum Gender { init, male, female, other }

List<Gender> genders = [Gender.male, Gender.female, Gender.other];

extension GenderExt on Gender {
  String get value {
    switch (this) {
      case Gender.male:
        return 'MALE';
      case Gender.female:
        return 'FEMALE';
      case Gender.init:
        return 'INIT';
      default:
        return 'OTHER';
    }
  }
}

extension GenderExt2 on Gender {
  String get label {
    switch (this) {
      case Gender.male:
        return 'Nam';
      case Gender.female:
        return 'Nữ';
      case Gender.init:
        return 'Init';
      default:
        return 'Khác';
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
        return 'Tất cả';
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
        return 'Đang chờ';
      case AppointmentStatus.completed:
        return 'Đã hoàn thành';
      case AppointmentStatus.cancelled:
        return 'Đã hủy';
      case AppointmentStatus.inProgress:
        return 'Đang tiến hành';
      default:
        return 'Tất cả';
    }
  }
}

extension StringToEnum on String {
  AppointmentType get enumType {
    switch (this) {
      case 'ONLINE':
        return AppointmentType.online;
      case 'OFFLINE':
        return AppointmentType.offline;
      default:
        return AppointmentType.all;
    }
  }

  AppointmentStatus get enumStatus {
    switch (this) {
      case 'PENDING':
        return AppointmentStatus.pending;
      case 'COMPLETED':
        return AppointmentStatus.completed;
      case 'CANCELLED':
        return AppointmentStatus.cancelled;
      case 'IN_PROGRESS':
        return AppointmentStatus.inProgress;
      default:
        return AppointmentStatus.all;
    }
  }
}

extension DebugLog on String {
  void debugLog(String title) {
    return debugPrint(
      '\n********************************** DebugLog **********************************\n'
      ' $title: $this'
      '\n********************************** DebugLog **********************************\n',
      wrapWidth: 1024,
    );
  }
}
