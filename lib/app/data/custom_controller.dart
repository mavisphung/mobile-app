import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/storage/storage.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class CustomController extends GetxController {
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

  void _checkLocale() {
    isEnglish.value = myLocale.languageCode == 'en' && myLocale.countryCode == 'US' ? true : false;
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
}
