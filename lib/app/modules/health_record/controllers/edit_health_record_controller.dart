import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/storage/box.dart';
import 'package:hi_doctor_v2/app/common/storage/storage.dart';
import 'package:hi_doctor_v2/app/common/util/transformation.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/models/health_record.dart';
import 'package:hi_doctor_v2/app/models/pathology.dart';
import 'package:hi_doctor_v2/app/models/record.dart';
import 'package:image_picker/image_picker.dart';

class EditHealthRecordController extends GetxController {
  final _pathologies = <Pathology>[];
  List<Pathology> get getPathologys => _pathologies;
  final _records = <Record>[];
  List<Record> get getRecords => _records;
  final _imgs = <String>[];
  List<String> get getImgs => _imgs;

  final pathologiesLength = 0.obs;
  final recordsLength = 0.obs;
  final imgsLength = 0.obs;
  final recordId = 0.obs;

  final nameController = TextEditingController();
  final nameFocusNode = FocusNode();
  final pathologyText = 'Tap to find pathology'.obs;

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

  List<String>? getTicketsWithRecordId(int recordId) {
    final item = _records.firstWhereOrNull((e) => e.id == recordId);
    if (item != null) {
      return item.tickets;
    }
    return null;
  }

  void addImage(bool isFromCamera) async {
    final url = await _getImage(isFromCamera);
    if (url != null) {
      _imgs.add(url);
      ++imgsLength.value;
    }
  }

  void removeImage(int index) {
    _imgs.removeAt(index);
    --imgsLength.value;
  }

  void addPathology() {
    final p = pathologyText.value;
    if (p == 'Tap to find pathology') return;
    final codeName = Tx.getPathologyCodeName(p);
    final pathology = Pathology(0, codeName[0], codeName[1]);
    _pathologies.add(pathology);
    ++pathologiesLength.value;
    pathologyText.value = 'Tap to find pathology';
  }

  void removePathology(int index) {
    _pathologies.removeAt(index);
    --pathologiesLength.value;
  }

  void _clearImgs() {
    _imgs.clear();
    imgsLength.value = 0;
  }

  void addTicket() {
    final imgs = _imgs.toList();
    final rId = recordId.value;
    final existedRecordIndex = _records.indexWhere((e) => e.id == rId);

    if (existedRecordIndex == -1) {
      final String typeName;
      switch (rId) {
        case 0:
          typeName = 'Phiếu điện tim';
          break;
        case 1:
          typeName = 'Phiếu siêu âm';
          break;
        case 2:
          typeName = 'Phiếu chụp X-quang';
          break;
        case 3:
          typeName = 'Phiếu ra viện';
          break;
        case 4:
          typeName = 'Phiếu xét nghiệm huyết học';
          break;
        case 5:
          typeName = 'Đơn thuốc';
          break;
        case 6:
          typeName = 'Sinh hiệu';
          break;
        case 7:
          typeName = 'Khác';
          break;
        default:
          typeName = 'Khác';
          break;
      }
      final record = Record(recordId.value, typeName, imgs);
      _records.add(record);
      ++recordsLength.value;
    } else {
      var tmp = _records[existedRecordIndex].tickets?.toList();
      tmp?.addAll(imgs);
      if (tmp != null) _records[existedRecordIndex].setTickets(tmp);
    }
    _clearImgs();
  }

  void removeTicket(int recordIndex, int index) {
    final record = _records.elementAt(recordIndex);
    var tmp = record.tickets?.toList();
    if (tmp != null) {
      tmp.removeAt(index);
      record.setTickets(tmp);
    }
  }

  void removeRecord(int index, String recordName) async {
    final confirm = await Utils.showConfirmDialog(
      '$recordName và tất cả ảnh trong đó sẽ bị xóa.\nBạn có chắc muốn xóa $recordName?',
      title: 'Xóa $recordName',
    );
    if (confirm ?? false) {
      _records.removeAt(index);
      --recordsLength.value;
    }
  }

  void saveHealthRecord() async {
    final healtRecord = HealthRecord(
      null,
      nameController.text.trim(),
      DateTime.now(),
      _pathologies.toList(),
      _records.toList(),
    );

    // var myOtherRecords = Box.otherRecords?.toList() ?? <HealthRecord>[];
    var myOtherRecords = <HealthRecord>[];
    // myOtherRecords.add(healtRecord);
    await Storage.saveValue(CacheKey.RECORDS.name, healtRecord);
    Get.back();
  }

  @override
  void dispose() {
    pathologiesLength.close();
    recordsLength.close();
    imgsLength.close();
    recordId.close();
    nameController.dispose();
    nameFocusNode.dispose();
    pathologyText.close();
    super.dispose();
  }
}
