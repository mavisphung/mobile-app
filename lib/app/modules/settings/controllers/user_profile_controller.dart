import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/storage/storage.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/status.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/data/response_model.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';
import 'package:hi_doctor_v2/app/modules/settings/controllers/settings_controller.dart';
import 'package:hi_doctor_v2/app/modules/settings/providers/api_settings_impl.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileController extends GetxController {
  final firstNameFocusNode = FocusNode();
  final lastNameFocusNode = FocusNode();
  final addressFocusNode = FocusNode();
  final phoneNumberFocusNode = FocusNode();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final address = TextEditingController();
  final phoneNumber = TextEditingController();
  final dob = DateTime.now().obs;
  final gender = userGender.first['value']!.obs;
  final avatar = ''.obs;

  var _profile = UserInfo2();
  final status = Status.init.obs;

  final _provider = Get.put(ApiSettingsImpl());

  late XFile? file;
  final ImagePicker _picker = ImagePicker();

  UserInfo2 get profile => _profile;

  _setInitialValue() {
    firstName.text = profile.firstName ?? '';
    lastName.text = profile.lastName ?? '';
    address.text = profile.address ?? '';
    phoneNumber.text = profile.phoneNumber ?? '';
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
          avatar: response.data['avatar'] ?? Constants.defaultAvatar,
        );
        dob.value = Utils.parseStrToDate('2022-10-08') ?? DateTime.now();
        gender.value = response.data['gender'];
        avatar.value = response.data['avatar'];
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
    dob.close();
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

  void getImage(bool isFromCamera) async {
    file = isFromCamera
        ? await _picker.pickImage(source: ImageSource.camera)
        : await _picker.pickImage(source: ImageSource.gallery);
    if (file == null) {
      return;
    }
    List<XFile> files = <XFile>[];
    files.add(file!);
    var response = await _provider.postPresignedUrls(files);
    if (response.isOk) {
      ResponseModel1 resModel = ResponseModel1.fromJson(response.body);
      String fileExt = file!.name.split('.')[1];
      String fullUrl = resModel.data['urls'][0];
      String url = fullUrl.split('?')[0];

      await Utils.upload(fullUrl, File(file!.path), fileExt);
      try {
        avatar.value = url;
      } catch (e) {
        print('error $e');
        rethrow;
      }
    }
  }

  Future<void> updateUserProfile(SettingsController settingsController) async {
    // Update UI to prevent multiple taps
    setStatusLoading();

    UserInfo2 info = UserInfo2(
      firstName: firstName.value.text,
      lastName: lastName.value.text,
      phoneNumber: phoneNumber.value.text,
      address: address.value.text,
      gender: gender.value,
      avatar: avatar.value,
    );
    var response = await _provider.putUserProfile(info);
    if (response.isOk) {
      _profile = info;

      final oldData = Storage.getValue<UserInfo2>(CacheKey.USER_INFO.name);
      final userInfo = info.copyWith(
        id: oldData?.id,
        email: oldData?.email,
      );

      await Storage.saveValue(CacheKey.USER_INFO.name, userInfo);
      settingsController.userInfo.value = userInfo;
      setStatusSuccess();
      Get.back();
      Utils.showTopSnackbar(Strings.updateProfileMsg.tr, title: 'Notice');
    } else {
      Get.snackbar('Error ${response.statusCode}', 'Error while updating profile', backgroundColor: Colors.red);
      setStatusFail();
    }
  }
}
