import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/storage/storage.dart';
import '../../../common/util/extensions.dart';
import '../../../data/settings/api_settings.dart';
import '../../../data/settings/api_settings_impl.dart';
import '../../../models/user_info.dart';
import '../../../routes/app_pages.dart';

class SettingsController extends GetxController {
  TextEditingController emailController = TextEditingController();
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

  Future<UserInfo?> getUserInfo() async {
    final accessToken = Storage.getValue<String>(CacheKey.TOKEN.name);
    if (accessToken != null) {
      final response = await _apiSettings.getUserInfo(accessToken).futureValue(showLoading: false);

      if (response != null) {
        if (response.isSuccess == true && response.statusCode == 201) {
          return UserInfo.fromMap(response.data);
        }
      }
    }
    return null;
  }

  @override
  void onInit() {
    _apiSettings = Get.put(ApiSettingsImpl());
    super.onInit();
  }
}
