import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';

import '../../../common/storage/storage.dart';
import '../../../common/util/extensions.dart';
import '../../../data/settings/api_settings.dart';
import '../../../data/settings/api_settings_impl.dart';
import '../../../models/user_info.dart';
import '../../../routes/app_pages.dart';

class SettingsController extends GetxController {
  TextEditingController emailController = TextEditingController();
  Rx<UserInfo2> userInfo = UserInfo2().obs;
  RxString avatar = ''.obs;
  late final ApiSettings _apiSettings;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void logOut() async {
    await Storage.clearStorage();
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<UserInfo2?> getUserInfo() async {
    final accessToken = Storage.getValue<String>(CacheKey.TOKEN.name);
    if (accessToken != null) {
      final response = await _apiSettings.getUserInfo(accessToken).futureValue(showLoading: false);

      if (response != null) {
        if (response.isSuccess == true && response.statusCode == 200) {
          userInfo.value = UserInfo2.fromMap(response.data);
          return userInfo.value;
        }
      }
    }
    return null;
  }

  @override
  void onInit() {
    super.onInit();
    _apiSettings = Get.put(ApiSettingsImpl());
    Map<String, dynamic> temp = Storage.getValue(CacheKey.USER.name) as Map<String, dynamic>;
    // print('${temp.runtimeType}');
    UserInfo2 userInfo = UserInfo2.fromMap(temp);
    avatar.value = userInfo.avatar ?? Constants.defaultAvatar;
  }
}
