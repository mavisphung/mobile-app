import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';

class UserProfileController extends GetxController {
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> firstName = TextEditingController().obs;
  Rx<TextEditingController> lastName = TextEditingController().obs;
  Rx<TextEditingController> address = TextEditingController().obs;
  Rx<TextEditingController> phoneNumber = TextEditingController().obs;
  Rx<UserInfo2> _profile = UserInfo2().obs;

  @override
  void onInit() {
    super.onInit();
    _profile.value = Get.arguments[Constants.info];
    firstName.value.text = _profile.value.firstName!;
    lastName.value.text = _profile.value.lastName!;
    address.value.text = _profile.value.address!;
    phoneNumber.value.text = _profile.value.phoneNumber!;
    print('Profile: ${_profile.value}');
  }

  UserInfo2 get profile => _profile.value;

  @override
  void dispose() {
    email.value.dispose();
    firstName.value.dispose();
    lastName.value.dispose();
    address.value.dispose();
    phoneNumber.value.dispose();
    email.close();
    firstName.close();
    lastName.close();
    address.close();
    phoneNumber.close();
    _profile.close();
    super.dispose();
  }

  String? isEmpty(String? value) {
    if (value != null && value.isNotEmpty) {
      return 'Not empty';
    }
    return null;
  }
}
