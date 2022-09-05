import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/storage/storage.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/data/response_model.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';
import 'package:hi_doctor_v2/app/modules/settings/controllers/settings_controller.dart';
import 'package:hi_doctor_v2/app/modules/settings/providers/api_settings_impl.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/util/status.dart';
import '../../../common/values/strings.dart';

class UserProfileController extends GetxController {
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> firstName = TextEditingController().obs;
  Rx<TextEditingController> lastName = TextEditingController().obs;
  Rx<TextEditingController> address = TextEditingController().obs;
  Rx<TextEditingController> phoneNumber = TextEditingController().obs;
  Rx<TextEditingController> avatar = TextEditingController().obs;
  // Lack of gender
  final _profile = UserInfo2().obs;
  final status = Status.init.obs;

  final _provider = Get.put(ApiSettingsImpl());

  late XFile? file;
  final ImagePicker _picker = ImagePicker();

  UserInfo2 get profile => _profile.value;

  _setInitialValue() {
    firstName.value.text = _profile.value.firstName!;
    lastName.value.text = _profile.value.lastName!;
    address.value.text = _profile.value.address!;
    phoneNumber.value.text = _profile.value.phoneNumber!;
  }

  Future<bool> getProfile() async {
    final response = await _provider.getProfile().futureValue();

    if (response != null) {
      if (response.isSuccess == true && response.statusCode == Constants.successGetStatusCode) {
        _profile.value = UserInfo2(
          id: response.data['id'],
          email: response.data['email'],
          firstName: response.data['firstName'],
          lastName: response.data['lastName'],
          address: response.data['address'],
          phoneNumber: response.data['phoneNumber'],
          gender: response.data['gender'],
          avatar: response.data['avatar'] ?? Constants.defaultAvatar,
        );
        _setInitialValue();
        return true;
      }
    }
    return false;
  }

  @override
  void dispose() {
    email.value.dispose();
    firstName.value.dispose();
    lastName.value.dispose();
    address.value.dispose();
    phoneNumber.value.dispose();
    avatar.value.dispose();
    email.close();
    firstName.close();
    lastName.close();
    address.close();
    phoneNumber.close();
    avatar.close();
    _profile.close();
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

  void getImage() async {
    file = await _picker.pickImage(source: ImageSource.camera);
    if (file == null) {
      return;
    }
    List<XFile> files = <XFile>[];
    files.add(file!);
    var response = await _provider.getPresignedUrls(files);
    if (response.isOk) {
      ResponseModel1 resModel = ResponseModel1.fromJson(response.body);
      String fileExt = file!.name.split('.')[1];
      String fullUrl = resModel.data['urls'][0];
      String url = fullUrl.split('?')[0];
      // String oldAvatar = _profile.value.avatar!;
      // print('fullUrl: $fullUrl');
      await Utils.upload(fullUrl, File(file!.path), fileExt);
      try {
        _profile.value.avatar = url;
        update();
      } catch (e) {
        print('error $e');
        rethrow;
      }
    }
  }

  Future<void> updateProfile(SettingsController settingsController) async {
    // Update UI to prevent multiple taps
    setStatusLoading();

    UserInfo2 info = UserInfo2(
      firstName: firstName.value.text,
      lastName: lastName.value.text,
      phoneNumber: phoneNumber.value.text,
      address: address.value.text,
      gender: _profile.value.gender,
      avatar: _profile.value.avatar,
    );
    var response = await _provider.updateProfile(info);
    if (response.isOk) {
      _profile.value = _profile.value.copyWith(
        firstName: firstName.value.text,
        lastName: lastName.value.text,
        address: address.value.text,
        phoneNumber: phoneNumber.value.text,
        gender: _profile.value.gender,
        avatar: _profile.value.avatar,
      );

      final oldData = Storage.getValue<Map<String, dynamic>>(CacheKey.USER_INFO.name);
      final userInfo = {
        'id': oldData?['id'],
        'email': oldData?['email'],
        'firstName': firstName.value.text,
        'lastName': lastName.value.text,
        'address': address.value.text,
        'phoneNumber': phoneNumber.value.text,
        'gender': _profile.value.gender,
        'avatar': _profile.value.avatar,
      };
      await Storage.saveValue(CacheKey.USER_INFO.name, userInfo);
      settingsController.userInfo.value = info.copyWith(
        id: oldData?['id'],
        email: oldData?['email'],
      );
      setStatusSuccess();
      Get.back();
      Utils.showTopSnackbar(Strings.updateProfileMsg.tr, title: 'Notice');
    } else {
      Get.snackbar('Error ${response.statusCode}', 'Error while updating profile', backgroundColor: Colors.red);
      setStatusFail();
    }
    update();
  }
}
