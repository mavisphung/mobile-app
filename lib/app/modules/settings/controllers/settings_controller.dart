import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/storage/storage.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class SettingsController extends GetxController {
  TextEditingController emailController = TextEditingController();
  final userInfo = UserInfo2().obs;
  final isEnglish = false.obs;
  Locale get myLocale {
    final locale = Storage.getValue<Locale>(CacheKey.LOCALE.name);
    return locale ?? const Locale('vi', 'VN');
  }

  @override
  void onInit() {
    _checkLocale();
    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _checkLocale() {
    print('LANGUGE: ${myLocale.languageCode}');
    isEnglish.value = myLocale.languageCode == 'en' && myLocale.countryCode == 'US' ? true : false;
    print(isEnglish);
  }

  void changeLanguage(bool value) async {
    var locale = value ? const Locale('en', 'US') : const Locale('vi', 'VN');
    await Storage.saveValue(CacheKey.LOCALE.name, locale);
    await Get.updateLocale(locale);
    _checkLocale();
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
      email: data?['email'],
      firstName: data?['firstName'],
      lastName: data?['lastName'],
      address: data?['address'],
      gender: data?['gender'],
      phoneNumber: data?['phoneNumber'],
      avatar: data?['avatar'],
    );
  }
}
