import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/transformation.dart';

import 'package:hi_doctor_v2/app/models/pathological.dart';
import 'package:image_picker/image_picker.dart';

class HealthRecordController extends GetxController {
  final _pathologicals = <Pathological>[];
  List<Pathological> get getPathologicals => _pathologicals;
  var pathologicalsLength = 0.obs;

  final nameController = TextEditingController();
  final pathologicalController = TextEditingController();
  final nameFocusNode = FocusNode();
  final pathologicalFocusNode = FocusNode();

  final _recordImgs = <String>[];
  List<String> get getRecordImgs => _recordImgs;
  var recordImgsLength = 0.obs;

  Future<String?> _getImage(bool isFromCamera) async {
    final picker = ImagePicker();
    XFile? file = isFromCamera
        ? await picker.pickImage(source: ImageSource.camera)
        : await picker.pickImage(source: ImageSource.gallery);
    if (file == null) {
      return null;
    }
    return file.path;
    // List<XFile> files = <XFile>[];
    // files.add(file);
    // var response = await _provider.postPresignedUrls(files);
    // if (response.isOk) {
    //   ResponseModel1 resModel = ResponseModel1.fromJson(response.body);
    //   String fileExt = file.name.split('.')[1];
    //   String fullUrl = resModel.data['urls'][0];
    //   String url = fullUrl.split('?')[0];

    //   await Utils.upload(fullUrl, File(file.path), fileExt);
    //   print('URL: $url');
    //   return url;
    // }
    // return null;
  }

  void addRecordImage(bool isFromCamera) async {
    // final settingsController = Get.put(SettingsController());
    final url = await _getImage(isFromCamera);
    if (url != null) {
      _recordImgs.add(url);
      // recordImgsLength.value = _recordImgs.length;
      recordImgsLength.value = ++recordImgsLength.value;
    }
  }

  void savePathological() {
    final codeName = Tx.getPathologicalCodeName(pathologicalController.text.trim());
    final pathological = Pathological(0, codeName[0], codeName[1], _recordImgs);
    // final pathological = Pathological(0, 'why', 'humm', _recordImgs);
    _pathologicals.add(pathological);
    ++pathologicalsLength.value;
  }

  void saveHealthRecord() {}

  @override
  void dispose() {
    pathologicalsLength.close();
    nameController.dispose();
    pathologicalController.dispose();
    nameFocusNode.dispose();
    pathologicalFocusNode.dispose();
    recordImgsLength.close();
    super.dispose();
  }
}
