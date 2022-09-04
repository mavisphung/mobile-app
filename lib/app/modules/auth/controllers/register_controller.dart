import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/constants.dart';
import '../../../common/util/extensions.dart';
import '../../../common/util/status.dart';
import '../../../common/util/utils.dart';
import '../../../common/values/strings.dart';
import '../../../routes/app_pages.dart';
import '../providers/api_auth.dart';
import '../providers/api_auth_impl.dart';

class RegisterController extends GetxController {
  late final ApiAuth _apiAuth;
  final nextStatus = Status.init.obs;
  final otpFormKey = GlobalKey<FormState>();
  final isPolicyAgreed = false.obs;
  final otpCode = ''.obs;

  Future<bool?> checkEmailExisted(String email) async {
    Utils.unfocus();
    nextStatus.value = Status.loading;
    final response = await _apiAuth.postCheckEmailExisted(email).futureValue();

    if (response != null) {
      if (response.isSuccess == false &&
          response.statusCode == 400 &&
          response.data['user'][0] == '$email does not exist') {
        nextStatus.value = Status.success;
        return false;
      } else if (response.isSuccess == true && response.statusCode == Constants.successPostStatusCode) {
        nextStatus.value = Status.fail;
        return true;
      }
    }
    nextStatus.value = Status.fail;
    return null;
  }

  Future<bool> register(
    String email,
    String password,
    String confirmPassword,
    String firstName,
    String lastName,
    String phoneNumber,
    String address,
    String gender,
  ) async {
    Utils.unfocus();
    if (!isPolicyAgreed.value) {
      Utils.showAlertDialog(
        Strings.policyAgreementNeedMsg.tr,
        title: Strings.policyAgreementAlert.tr,
      );
      return false;
    }
    nextStatus.value = Status.loading;
    final response = await _apiAuth
        .postRegister(
          email,
          password,
          confirmPassword,
          firstName,
          lastName,
          phoneNumber,
          address,
          gender,
        )
        .futureValue();

    if (response != null && response.isSuccess == true && response.statusCode == Constants.successPostStatusCode) {
      nextStatus.value = Status.success;
      return true;
    }
    nextStatus.value = Status.fail;
    return false;
  }

  void activateAccount(String email, String code) async {
    Utils.unfocus();
    nextStatus.value = Status.loading;
    final response = await _apiAuth.postActivateAccount(email, code).futureValue();

    if (response != null && response.isSuccess && response.statusCode == Constants.successPostStatusCode) {
      Utils.showTopSnackbar(Strings.registerSuccessMsg.tr, title: Strings.registerSuccess.tr);
      nextStatus.value = Status.success;
      Get.offAllNamed(Routes.LOGIN);
    } else if (response != null &&
        !response.isSuccess &&
        response.statusCode == 400 &&
        response.message == 'NO_MATCHED_CODE') {
      Utils.showBottomSnackbar(Strings.otpErrorMsg.trParams({'code': otpCode.value}));
    } else if (response != null &&
        !response.isSuccess &&
        response.statusCode == 400 &&
        response.message == 'VERIFY_CODE_EXPIRED') {
      Utils.showBottomSnackbar(Strings.otpExpiredMsg.tr);
    }
    nextStatus.value = Status.fail;
  }

  Future<bool> resendOtp(String email) async {
    final response = await _apiAuth.postResendOtp(email).futureValue();

    if (response != null && response.isSuccess == true && response.statusCode == Constants.successPostStatusCode) {
      return true;
    }
    return false;
  }

  @override
  void onInit() {
    _apiAuth = Get.put(ApiAuthImpl());
    super.onInit();
  }
}
