import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/util/extensions.dart';
import '../../../common/util/utils.dart';
import '../../../data/auth/api_auth.dart';
import '../../../data/auth/api_auth_impl.dart';
import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  late final ApiAuth _apiAuth;
  final otpFormKey = GlobalKey<FormState>();
  var otpCode = ''.obs;
  var isPolicyAgreed = false.obs;

  Future<bool?> checkEmailExisted(String email) async {
    // Utils.unfocus();
    final response = await _apiAuth.postCheckEmailExisted(email).futureValue();

    if (response != null) {
      if (response.isSuccess == false &&
          response.statusCode == 400 &&
          response.data['user'][0] == '$email does not exist') {
        return false;
      } else if (response.isSuccess == true && response.statusCode == 201) {
        return true;
      }
    }
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
    // Utils.unfocus();
    if (!isPolicyAgreed.value) {
      Utils.showAlertDialog(
        'policy_agree_need_msg'.tr,
        title: 'policy_agree_alert'.tr,
      );
      return false;
    }
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

    if (response != null && response.isSuccess == true && response.statusCode == 201) {
      return true;
    }
    return false;
  }

  void activateAccount(String email, String code) async {
    Utils.unfocus();
    final response = await _apiAuth.postActivateAccount(email, code).futureValue();

    if (response != null && response.isSuccess && response.statusCode == 201) {
      Utils.showTopSnackbar('register_success_msg'.tr, title: 'register_success'.tr);
      Get.offAllNamed(Routes.LOGIN);
    } else if (response != null &&
        !response.isSuccess &&
        response.statusCode == 400 &&
        response.message == 'NO_MATCHED_CODE') {
      Utils.showBottomSnackbar('otp_incorrect_msg'.trParams({'code': otpCode.value}));
    } else if (response != null &&
        !response.isSuccess &&
        response.statusCode == 400 &&
        response.message == 'VERIFY_CODE_EXPIRED') {
      Utils.showBottomSnackbar('otp_expired_msg'.tr);
    }
  }

  Future<bool> resendOtp(String email) async {
    final response = await _apiAuth.postResendOtp(email).futureValue();

    if (response != null && response.isSuccess == true && response.statusCode == 201) {
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
