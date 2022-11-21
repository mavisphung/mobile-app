import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/storage/storage.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/enum.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';
import 'package:hi_doctor_v2/app/modules/auth/providers/api_auth.dart';
import 'package:hi_doctor_v2/app/modules/auth/providers/api_auth_impl.dart';
import 'package:hi_doctor_v2/app/modules/auth/providers/google_sign_in_api.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final loginStatus = Status.init.obs;
  late final ApiAuth _apiAuth;

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login(String email, String password) async {
    Utils.unfocus();
    loginStatus.value = Status.loading;
    final response = await _apiAuth.postLogin(email, password).futureValue();
    if (response != null && response.isSuccess == true && response.statusCode == Constants.successPostStatusCode) {
      await Storage.saveValue(CacheKey.TOKEN.name, response.data['accessToken']);
      await Storage.saveValue(CacheKey.IS_LOGGED.name, true);

      final userInfo = UserInfo2(
        id: response.data['id'],
        email: response.data['email'],
        firstName: response.data['firstName'],
        lastName: response.data['lastName'],
        address: response.data['address'],
        phoneNumber: response.data['phoneNumber'],
        gender: response.data['gender'],
        avatar: response.data['avatar'],
        dob: response.data['dob'],
      );
      await Storage.saveValue(CacheKey.USER_INFO.name, userInfo);

      Get.offNamed(Routes.NAVBAR);
      loginStatus.value = Status.success;
      return;
    }
    loginStatus.value = Status.fail;
  }

  Future<bool?> loginWithToken() async {
    final accessToken = Storage.getValue<String>(CacheKey.TOKEN.name);
    if (accessToken == null) return false;

    final response = await _apiAuth.getLoginWithToken(accessToken).futureValue();

    if (response != null) {
      if (response.isSuccess == true && response.statusCode == Constants.successGetStatusCode) {
        final userInfo = UserInfo2(
          id: response.data['id'],
          email: response.data['email'],
          firstName: response.data['firstName'],
          lastName: response.data['lastName'],
          address: response.data['address'],
          phoneNumber: response.data['phoneNumber'],
          gender: response.data['gender'],
          avatar: response.data['avatar'],
        );
        await Storage.saveValue(CacheKey.USER_INFO.name, userInfo);
        return true;
      } else {
        return false;
      }
    }
    return null;
  }

  Future<void> signInGoogle() async {
    try {
      GoogleSignInAccount? user = await GoogleSignInApi.login();
      if (user == null) {
        Utils.showAlertDialog('Xảy ra lỗi khi đăng nhập bằng Gmail', title: 'Cảnh báo');
        return;
      }
      user.email.toString().debugLog('Google account');
      GoogleSignInAuthentication key = await user.authentication;
      key.accessToken.toString().debugLog('AccessToken');
      key.idToken.toString().debugLog('IdToken');
      if (key.accessToken == null) {
        Utils.showAlertDialog('Email không được xác thực. Vui lòng kiểm tra lại', title: 'Cảnh báo');
        return;
      }
      await loginWithGoogleToken(key.accessToken!);
    } catch (e) {
      e.toString().debugLog('Error when invoking signInGoogle');
      Utils.showAlertDialog('google_sign_in_exception', title: 'Lỗi hệ thống');
    }
  }

  Future<void> loginWithGoogleToken(String ggAccessToken) async {
    final response = await _apiAuth.postGoogleLogin(ggAccessToken).futureValue();
    if (response != null && response.isSuccess == true && response.statusCode == Constants.successPostStatusCode) {
      await Storage.saveValue(CacheKey.TOKEN.name, response.data['accessToken']);
      await Storage.saveValue(CacheKey.IS_LOGGED.name, true);

      final userInfo = UserInfo2(
        id: response.data['id'],
        email: response.data['email'],
        firstName: response.data['firstName'],
        lastName: response.data['lastName'],
        address: response.data['address'],
        phoneNumber: response.data['phoneNumber'],
        gender: response.data['gender'],
        avatar: response.data['avatar'],
        dob: response.data['dob'],
      );
      await Storage.saveValue(CacheKey.USER_INFO.name, userInfo);

      Get.offNamed(Routes.NAVBAR);
      loginStatus.value = Status.success;
      update();
      return;
    }
    loginStatus.value = Status.fail;
    update();
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    emailController.dispose();
    passwordFocusNode.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    _apiAuth = Get.put(ApiAuthImpl());
    super.onInit();
  }
}
