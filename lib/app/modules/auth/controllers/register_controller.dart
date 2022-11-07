import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/status.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';
import 'package:hi_doctor_v2/app/modules/auth/providers/api_auth.dart';
import 'package:hi_doctor_v2/app/modules/auth/providers/api_auth_impl.dart';
import 'package:hi_doctor_v2/app/modules/auth/providers/req_auth_model.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  late final ApiAuth _apiAuth;
  final nextStatus = Status.init.obs;
  final dynamic isEmailDuplicated = false.obs;
  final gender = userGender.first['value']!.obs;
  final isPolicyAgreed = false.obs;
  String email = '';
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
        this.email = email;
        return false;
      } else if (response.isSuccess == true && response.statusCode == Constants.successPostStatusCode) {
        nextStatus.value = Status.fail;
        return true;
      }
    }
    nextStatus.value = Status.fail;
    return null;
  }

  Future<bool> register(RequestRegisterModel reqBody) async {
    Utils.unfocus();
    if (!isPolicyAgreed.value) {
      Utils.showAlertDialog(
        Strings.policyAgreementNeedMsg.tr,
      );
      return false;
    }
    nextStatus.value = Status.loading;
    final response = await _apiAuth.postRegister(reqBody).futureValue();

    if (response != null && response.isSuccess == true && response.statusCode == Constants.successPostStatusCode) {
      nextStatus.value = Status.success;
      print('REGISTER DATA: ${response.data}');
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
      Utils.showTopSnackbar(Strings.otpErrorMsg.trParams({'code': otpCode.value}));
    } else if (response != null &&
        !response.isSuccess &&
        response.statusCode == 400 &&
        response.message == 'VERIFY_CODE_EXPIRED') {
      Utils.showTopSnackbar(Strings.otpExpiredMsg.tr);
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
