import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:hi_doctor_v2/app/data/api_custom.dart';
import 'package:hi_doctor_v2/app/data/response_model.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/modules/health_record/controllers/health_record_controller.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/models/other_health_record.dart';
import 'package:hi_doctor_v2/app/models/pathology.dart';
import 'package:hi_doctor_v2/app/models/record.dart';
import 'package:hi_doctor_v2/app/modules/health_record/providers/api_health_record.dart';

class EditOtherHealthRecordController extends GetxController {
  late final ApiCustom _apiCustom;
  late final ApiHealthRecord _apiHealthRecord;
  late final HealthRecordController _cHealthRecord;

  OtherHealthRecord? _hr;
  Pathology? _p;

  set healthRecord(OtherHealthRecord value) => _hr = value;
  set pathology(Pathology value) => _p = value;

  final RxList<Pathology> _pathologies = RxList<Pathology>();
  final RxList<Record> _records = RxList<Record>();

  RxList<Pathology> get rxPathologies {
    if (_hr?.pathologies != null) {
      _pathologies.value = _hr!.pathologies!;
    }
    return _pathologies;
  }

  RxList<Record> get rxRecords {
    if (_hr?.otherTickets != null) {
      _records.value = _hr!.otherTickets!;
    } else if (_p?.records != null) {
      _records.value = _p!.records!;
    }
    return _records;
  }

  final imgs = RxList<XFile>();

  final recordId = 0.obs;

  final nameController = TextEditingController();
  final nameFocusNode = FocusNode();

  Future<XFile?> _getImage(bool isFromCamera) async {
    final picker = ImagePicker();
    XFile? file = isFromCamera
        ? await picker.pickImage(source: ImageSource.camera)
        : await picker.pickImage(source: ImageSource.gallery);
    if (file == null) {
      return null;
    }
    return file;
  }

  void addImage(bool isFromCamera) async {
    final file = await _getImage(isFromCamera);
    if (file != null) {
      imgs.add(file);
      imgs.refresh();
    }
  }

  void removeImage(int index) {
    imgs.removeAt(index);
    imgs.refresh();
  }

  void addPathology(Pathology p) {
    rxPathologies.add(p);
    rxPathologies.refresh();
    Get.until((route) => Get.currentRoute == '${Routes.EDIT_HEALTH_RECORD}?tag=ADD');
  }

  void updatePathology(Pathology p) {
    final existedItem = rxPathologies.indexWhere((e) => e.id == p.id);
    rxPathologies.setAll(existedItem, [p]);
    Get.until((route) => Get.currentRoute == '${Routes.EDIT_HEALTH_RECORD}?tag=ADD');
  }

  void removePathology(int index) async {
    final confirm = await Utils.showConfirmDialog(
      'Bệnh lý và những phiếu sức khỏe liên quan đến bệnh lý sẽ bị xóa. Bạn có chắc muốn xóa?',
      title: 'Xóa bệnh lý',
    );
    if (confirm ?? false) {
      rxPathologies.removeAt(index);
      rxPathologies.refresh();
    }
  }

  void _clearImgs() {
    imgs.clear();
    imgs.refresh();
  }

  void addTicket() {
    final existedRecordIndex = rxRecords.indexWhere((e) => e.id == recordId.value);

    if (existedRecordIndex == -1) {
      final String? typeName = recordType[recordId.value];
      final record = Record(recordId.value, typeName, [], imgs.toList());
      rxRecords.add(record);
      rxRecords.refresh();
    } else {
      var tmp = rxRecords[existedRecordIndex].xFiles;
      if (tmp != null) {
        tmp.addAll(imgs.toList());
      }
    }
    _clearImgs();
  }

  void removeTicket(int recordIndex, int index) {
    final record = rxRecords.elementAt(recordIndex);
    var tmp = record.xFiles?.toList();
    if (tmp != null) {
      tmp.removeAt(index);
      record.xFiles = tmp;
    }
  }

  void removeRecord(int index, String recordName) async {
    final confirm = await Utils.showConfirmDialog(
      '$recordName và tất cả ảnh trong đó sẽ bị xóa.\nBạn có chắc muốn xóa $recordName?',
      title: 'Xóa $recordName',
    );
    if (confirm ?? false) {
      rxRecords.removeAt(index);
      rxRecords.refresh();
    }
  }

  Future<bool?> addOtherHealthRecord() async {
    if (nameController.text.isEmpty && (rxPathologies.isEmpty || rxRecords.isEmpty)) {
      Utils.showAlertDialog('Bạn cần đặt tên hồ sơ và thêm ít nhất một bệnh lý hoặc phiếu sức khỏe.');
      return null;
    }
    await _assignUrls();
    final hr = OtherHealthRecord(
      null,
      nameController.text.trim(),
      DateTime.now(),
      rxPathologies.toList(),
      rxRecords.toList(),
    );

    final patientId = _cHealthRecord.patient.value.id;
    if (patientId != null) {
      final response = await _apiHealthRecord.postHealthRecord(patientId, hr).futureValue();
      print('ADD RESP: ${response.toString()}');
      if (response != null && response.isSuccess) {
        return true;
      } else if (response != null && !response.isSuccess) {
        return false;
      }
    }
    return null;
  }

  Future<List<String>?> _registerImgs(List<XFile> files) async {
    final urls = <String>[];
    String fileExt, fullUrl, url;
    var response = await _apiCustom.postPresignedUrls(files);
    if (response.isOk) {
      ResponseModel1 resModel = ResponseModel1.fromJson(response.body);
      for (int i = 0; i < files.length; ++i) {
        fileExt = files[i].name.split('.')[1];
        fullUrl = resModel.data['urls'][i];
        url = fullUrl.split('?')[0];
        await Utils.upload(fullUrl, File(files[i].path), fileExt);
        urls.add(url);
      }
      return urls;
    }
    return null;
  }

  Future<void> _assignUrls() async {
    List<String> urls;
    for (var p in rxPathologies) {
      if (p.records != null) {
        for (var r in p.records!) {
          final pXFiles = r.xFiles;
          if (pXFiles != null) {
            urls = await _registerImgs(pXFiles) ?? [];
            r.tickets = urls;
          }
        }
      }
    }
    for (var r in rxRecords) {
      final hrXFiles = r.xFiles;
      if (hrXFiles != null) {
        urls = await _registerImgs(hrXFiles) ?? [];
        r.tickets = urls;
      }
    }
  }

  void updateOtherHealthRecord() {
    Get.back();
  }

  @override
  void onInit() {
    _apiCustom = Get.put(ApiCustom());
    _apiHealthRecord = Get.put(ApiHealthRecord());
    _cHealthRecord = Get.find<HealthRecordController>();
    super.onInit();
  }

  @override
  void dispose() {
    rxPathologies.clear();
    rxPathologies.close();
    rxRecords.clear();
    rxRecords.close();
    _pathologies.clear();
    _pathologies.close();
    _records.clear();
    _records.close();
    imgs.clear();
    imgs.close();
    recordId.close();
    nameController.dispose();
    nameFocusNode.dispose();
    super.dispose();
  }
}
