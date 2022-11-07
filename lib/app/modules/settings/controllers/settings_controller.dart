import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/storage/box.dart';
import 'package:hi_doctor_v2/app/common/storage/storage.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class SettingsController extends GetxController {
  late final Rx<UserInfo2> userInfo;

  void logOut() async {
    await Storage.clearStorage();
    Get.offAllNamed(Routes.LOGIN);
  }

  @override
  void onInit() {
    super.onInit();
    userInfo.value = Box.getCacheUser();
  }
}
