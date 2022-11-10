import 'dart:io';

import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/data/api_custom.dart';
import 'package:hi_doctor_v2/app/data/response_model.dart';
import 'package:image_picker/image_picker.dart';

class CustomController extends GetxController {
  late final ApiCustom _provider;

  @override
  void onInit() {
    _provider = Get.put(ApiCustom());
    super.onInit();
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
