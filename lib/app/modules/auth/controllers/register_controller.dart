import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/util/extensions.dart';
import '../../../common/util/utils.dart';
import '../../../common/values/strings.dart';
import '../../../routes/app_pages.dart';
import '../providers/api_auth.dart';
import '../providers/api_auth_impl.dart';

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
        Strings.policyAgreementNeedMsg.tr,
        title: Strings.policyAgreementAlert.tr,
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
      Utils.showTopSnackbar(Strings.registerSuccessMsg.tr, title: Strings.registerSuccess.tr);
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
