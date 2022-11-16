import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:hi_doctor_v2/app/modules/health_record/models/hr_res_model.dart';
import 'package:hi_doctor_v2/app/common/util/enum.dart';
import 'package:hi_doctor_v2/app/data/api_custom.dart';
import 'package:hi_doctor_v2/app/data/response_model.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/modules/health_record/controllers/health_record_controller.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/models/other_health_record.dart';
import 'package:hi_doctor_v2/app/models/pathology.dart';
import 'package:hi_doctor_v2/app/models/record.dart';
import 'package:hi_doctor_v2/app/modules/health_record/providers/api_health_record.dart';

class EditOtherHealthRecordController extends GetxController {
  final _picker = ImagePicker();
  final recordId = 0.obs;

  late final ApiCustom _apiCustom;
  late final ApiHealthRecord _apiHealthRecord;
  late final HealthRecordController _cHealthRecord;

  late final HrResModel? _hrResModel;

  late final RxList<Pathology> _pathologies;
  late final RxList<Record> _records;

  RxList<Pathology> get rxPathologies => _pathologies;
  RxList<Record> get rxRecords => _records;

  final imgs = RxList<XFile>();

  final nameController = TextEditingController();
  final nameFocusNode = FocusNode();

  final status = Status.init.obs;

  Future<bool> initialize(HrResModel? hr) {
    if (hr != null) {
      _hrResModel = hr;
      final pList = hr.detail?['pathologies'] as List;
      _pathologies = pList.map((e) => Pathology.fromMap(e)).toList().obs;
      final rList = hr.detail?['otherTickets'] as List;
      _records = rList.map((e) => Record.fromMap(e)).toList().obs;
    } else {
      _pathologies = RxList<Pathology>();
      _records = RxList<Record>();
    }
    return Future.value(true);
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

  Future<XFile?> _getImage(bool isFromCamera) async {
    XFile? file = isFromCamera
        ? await _picker.pickImage(source: ImageSource.camera)
        : await _picker.pickImage(source: ImageSource.gallery);
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

  void removePathology(int index) async {
    final confirm = await Utils.showConfirmDialog(
      'Bệnh lý và những phiếu sức khỏe liên quan đến bệnh lý sẽ bị xóa. Bạn có chắc muốn xóa?',
      title: 'Xóa bệnh lý',
    );
    if (confirm ?? false) {
      _pathologies.removeAt(index);
      _pathologies.refresh();
    }
  }

  void _clearImgs() {
    imgs.clear();
    imgs.refresh();
  }

  void addTicket() {
    final existedRecordId = _records.indexWhere((e) => e.id == recordId.value);

    if (existedRecordId == -1) {
      final String? typeName = recordType[recordId.value];
      final record = Record(recordId.value, typeName, [], imgs.toList());
      _records.add(record);
      _records.refresh();
    } else {
      var xFiles = _records[existedRecordId].xFiles;
      if (xFiles != null) {
        xFiles.addAll(imgs.toList());
        _records.refresh();
      }
    }
    _clearImgs();
  }

  void removeTicket(int recordId, int index) {
    final record = _records.firstWhere((e) => e.id == recordId);

    if (index < record.tickets!.length) {
      record.tickets!.removeAt(index);
    } else {
      record.xFiles!.removeAt(index - record.tickets!.length);
    }
  }

  void removeRecord(int recordId, String recordName) async {
    final confirm = await Utils.showConfirmDialog(
      '$recordName và tất cả ảnh trong đó sẽ bị xóa.\nBạn có chắc muốn xóa $recordName?',
      title: 'Xóa $recordName',
    );
    if (confirm ?? false) {
      _records.removeWhere((e) => e.id == recordId);
      _records.refresh();
    }
  }

  Future<bool?> addOtherHealthRecord() async {
    if (nameController.text.isEmpty || (_pathologies.isEmpty && _records.isEmpty)) {
      Utils.showAlertDialog('Bạn cần đặt tên hồ sơ và thêm ít nhất một bệnh lý hoặc phiếu sức khỏe.');
      return null;
    }
    setStatusLoading();
    await _assignUrls();
    final hr = OtherHealthRecord(
      null,
      nameController.text.trim(),
      DateTime.now(),
      _pathologies.toList(),
      _records.toList(),
    );

    final patientId = _cHealthRecord.patient.value.id;
    if (patientId != null) {
      final response = await _apiHealthRecord.postHealthRecord(patientId, hr).futureValue();
      print('ADD RESP: ${response.toString()}');
      if (response != null && response.isSuccess) {
        setStatusSuccess();
        return true;
      } else if (response != null && !response.isSuccess) {
        setStatusFail();
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
    for (var p in _pathologies) {
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
    for (var r in _records) {
      final hrXFiles = r.xFiles;
      if (hrXFiles != null) {
        urls = await _registerImgs(hrXFiles) ?? [];
        r.tickets = urls;
      }
    }
  }

  Future<bool?> updateOtherHealthRecord() {
    Get.back();
    return Future.value(false);
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
    _records.clear();
    _records.close();
    _pathologies.clear();
    _pathologies.close();
    _records.clear();
    _records.close();
    imgs.clear();
    imgs.close();
    recordId.close();
    nameController.dispose();
    nameFocusNode.dispose();
    status.close();
    super.dispose();
  }
}
