import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/storage/box.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';

class SettingsController extends GetxController {
  final userInfo = UserInfo2().obs;

  void getUserInfo() {
    final data = Box.userInfo;
    userInfo.value = UserInfo2(
      id: data?.id,
      email: data?.email,
      firstName: data?.firstName,
      lastName: data?.lastName,
      address: data?.address,
      gender: data?.gender,
      phoneNumber: data?.phoneNumber,
      avatar: data?.avatar,
    );
  }
}
