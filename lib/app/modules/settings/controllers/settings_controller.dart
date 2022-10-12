import 'dart:io';

import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/storage/box.dart';

import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/data/response_model.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';
import 'package:hi_doctor_v2/app/modules/settings/providers/api_settings_impl.dart';
import 'package:image_picker/image_picker.dart';

class SettingsController extends GetxController {
  final _provider = Get.put(ApiSettingsImpl());
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

  Future<String?> getImage(bool isFromCamera) async {
    final picker = ImagePicker();
    XFile? file = isFromCamera
        ? await picker.pickImage(source: ImageSource.camera)
        : await picker.pickImage(source: ImageSource.gallery);
    if (file == null) {
      return null;
    }
    List<XFile> files = <XFile>[];
    files.add(file);
    var response = await _provider.postPresignedUrls(files);
    if (response.isOk) {
      ResponseModel1 resModel = ResponseModel1.fromJson(response.body);
      String fileExt = file.name.split('.')[1];
      String fullUrl = resModel.data['urls'][0];
      String url = fullUrl.split('?')[0];

      await Utils.upload(fullUrl, File(file.path), fileExt);
      print('URL: $url');
      return url;
    }
    return null;
  }
}
