import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/storage/box.dart';
import 'package:hi_doctor_v2/app/common/storage/storage.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/status.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/data/custom_controller.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';
import 'package:hi_doctor_v2/app/modules/settings/controllers/settings_controller.dart';
import 'package:hi_doctor_v2/app/modules/settings/providers/api_settings_impl.dart';

class UserProfileController extends GetxController {
  final firstNameFocusNode = FocusNode();
  final lastNameFocusNode = FocusNode();
  final addressFocusNode = FocusNode();
  final phoneNumberFocusNode = FocusNode();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final address = TextEditingController();
  final phoneNumber = TextEditingController();
  final dob = TextEditingController();
  final gender = userGender.first['value']!.obs;
  final avatar = ''.obs;

  var _profile = UserInfo2();
  final status = Status.init.obs;

  final _provider = Get.put(ApiSettingsImpl());

  UserInfo2 get profile => _profile;

  _setInitialValue() {
    firstName.text = profile.firstName ?? '';
    lastName.text = profile.lastName ?? '';
    address.text = profile.address ?? '';
    phoneNumber.text = profile.phoneNumber ?? '';
    avatar.value = profile.avatar ?? Constants.defaultAvatar;
    dob.text = profile.dob ?? '2000-10-24';
    gender.value = profile.gender ?? userGender.first['value']!;
  }

  Future<bool> getProfile() async {
    final response = await _provider.getProfile().futureValue();

    if (response != null) {
      if (response.isSuccess == true && response.statusCode == Constants.successGetStatusCode) {
        _profile = UserInfo2(
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
        _setInitialValue();
        return true;
      }
    }
    return false;
  }

  @override
  void dispose() {
    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    addressFocusNode.dispose();
    phoneNumberFocusNode.dispose();
    firstName.dispose();
    lastName.dispose();
    address.dispose();
    phoneNumber.dispose();
    dob.dispose();
    gender.close();
    avatar.close();
    super.dispose();
  }

  String? isEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    return null;
  }

  void setStatusLoading() {
    status.value = Status.loading;
  }

  void setStatusSuccess() {
    status.value = Status.success;
  }

  void setStatusFail() {
    status.value = Status.fail;
  }

  void setAvatar(bool isFromCamera) async {
    final cCustom = Get.find<CustomController>();
    final url = await cCustom.getImage(isFromCamera);
    if (url != null) avatar.value = url;
  }

  Future<void> updateUserProfile() async {
    setStatusLoading();

    UserInfo2 info = UserInfo2(
      firstName: firstName.value.text,
      lastName: lastName.value.text,
      phoneNumber: phoneNumber.value.text,
      address: address.value.text,
      gender: gender.value,
      avatar: avatar.value,
      dob: dob.value.text,
    );
    var response = await _provider.putUserProfile(info);
    if (response.isOk) {
      _profile = info;

      final oldData = Box.getCacheUser();
      final userInfo = info.copyWith(
        id: oldData.id,
        email: oldData.email,
      );

      await Storage.saveValue(CacheKey.USER_INFO.name, userInfo);
      final cSettings = Get.find<SettingsController>();
      cSettings.userInfo.value = userInfo;

      setStatusSuccess();
      Get.back();
      Utils.showTopSnackbar(Strings.updateProfileMsg);
    } else {
      Get.snackbar('Error ${response.statusCode}', 'Error while updating profile', backgroundColor: Colors.red);
      setStatusFail();
    }
  }
}
