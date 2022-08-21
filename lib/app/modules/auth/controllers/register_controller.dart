import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/util/extensions.dart';
import '../../../data/auth/api_auth.dart';
import '../../../data/auth/api_auth_impl.dart';

class RegisterController extends GetxController {
  final ApiAuth _apiAuth = Get.put(ApiAuthImpl());
  final otpFormKey = GlobalKey<FormState>();
  var otpCode = ''.obs;

  Future<bool?> checkEmailExisted(String email) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final response = await _apiAuth.postCheckEmailExisted(email).futureValue();

    if (response != null) {
      if (response.isSuccess == false &&
          response.statusCode == 400 &&
          response.data['user'][0] == '$email does not exist') {
        print('DOES NOT EXISTEDDDDDDDDDDDDDDDDDDDD');
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
    FocusManager.instance.primaryFocus?.unfocus();
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

    if (response != null &&
        response.isSuccess == true &&
        response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<bool> activateAccount(String email, String code) async {
    final response =
        await _apiAuth.postActivateAccount(email, code).futureValue();

    if (response != null &&
        response.isSuccess == true &&
        response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<bool> resendOtp(String email) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final response = await _apiAuth.postResendOtp(email).futureValue();

    if (response != null &&
        response.isSuccess == true &&
        response.statusCode == 201) {
      return true;
    }
    return false;
  }
}
