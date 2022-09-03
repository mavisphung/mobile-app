import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';

import '../../../common/storage/storage.dart';
import '../../../common/util/extensions.dart';
import '../../../models/user_info.dart';
import '../../../routes/app_pages.dart';
import '../providers/api_settings.dart';
import '../providers/api_settings_impl.dart';

class SettingsController extends GetxController {
  TextEditingController emailController = TextEditingController();
  // Rx<UserInfo2> userInfo = UserInfo2().obs;
  // RxString avatar = ''.obs;
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

  UserInfo2 getUserInfo() {
    final data = Storage.getValue<Map<String, dynamic>>(CacheKey.USER_INFO.name);
    print('DATA: $data');
    return UserInfo2(
      id: data?['id'],
      email: data?['email'] ?? '',
      firstName: data?['firstName'] ?? '',
      lastName: data?['lastName'] ?? '',
      address: data?['address'] ?? '',
      gender: data?['gender'] ?? '',
      phoneNumber: data?['phoneNumber'] ?? '',
      avatar: data?['avatar'] ?? Constants.defaultAvatar,
    );
  }

  @override
  void onInit() {
    super.onInit();
    _apiSettings = Get.put(ApiSettingsImpl());
    // Map<String, dynamic> temp = Storage.getValue(CacheKey.USER.name) as Map<String, dynamic>;
    // // print('${temp.runtimeType}');
    // UserInfo2 userInfo = UserInfo2.fromMap(temp);
    // avatar.value = userInfo.avatar ?? Constants.defaultAvatar;
  }
}
