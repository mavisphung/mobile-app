import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/constants.dart';
import '../../../common/storage/storage.dart';
import '../../../models/user_info.dart';
import '../../../routes/app_pages.dart';

class SettingsController extends GetxController {
  TextEditingController emailController = TextEditingController();
  final userInfo = UserInfo2().obs;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void logOut() async {
    await Storage.clearStorage();
    Get.offAllNamed(Routes.LOGIN);
  }

  void getUserInfo() {
    final data = Storage.getValue<Map<String, dynamic>>(CacheKey.USER_INFO.name);
    print('DATA: $data');
    userInfo.value = UserInfo2(
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
}
