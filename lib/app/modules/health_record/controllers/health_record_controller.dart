import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/transformation.dart';

import 'package:hi_doctor_v2/app/models/pathology.dart';
import 'package:hi_doctor_v2/app/models/record.dart';
import 'package:image_picker/image_picker.dart';

// ignore: constant_identifier_names
enum PathologyNameStatus { INITIAL, EMPTY, INVALID, VALID }

class HealthRecordController extends GetxController {
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
  final pathologyController = TextEditingController();
  final nameFocusNode = FocusNode();
  final pathologyFocusNode = FocusNode();
  final pathologyNameStatus = PathologyNameStatus.INITIAL.obs;

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
    final codeName = Tx.getPathologyCodeName(pathologyController.text.trim());
    final pathology = Pathology(0, codeName[0], codeName[1]);
    _pathologies.add(pathology);
    ++pathologiesLength.value;
  }

  void _clearImgs() {
    _imgs.clear();
    imgsLength.value = 0;
  }

  void addTicket() {
    final String typeName;
    final rId = recordId.value;
    switch (rId) {
      case 0:
        typeName = 'Phiếu điện tim';
        break;
      case 1:
        typeName = 'Đơn thuốc';
        break;
      case 2:
        typeName = 'Khác';
        break;
      default:
        typeName = 'Khác';
        break;
    }
    final imgs = _imgs.toList();
    final record = Record(recordId.value, typeName, imgs);
    final existedRecordIndex = _records.indexWhere((e) => e.id == rId);
    if (existedRecordIndex == -1) {
      _records.add(record);
      ++recordsLength.value;
    } else {
      var tmp = _records[existedRecordIndex].tickets?.toList();
      tmp?.addAll(imgs);
      if (tmp != null) _records[existedRecordIndex].setTickets(tmp);
    }
    _clearImgs();
  }

  void removeTicket(int recordId, int index) {
    final record = _records.firstWhereOrNull((e) => e.id == recordId);
    if (record != null) {
      var tmp = record.tickets?.toList();
      if (tmp != null) {
        tmp.removeAt(index);
        record.setTickets(tmp);
      }
    }
  }

  void saveHealthRecord() {}

  @override
  void dispose() {
    pathologiesLength.close();
    recordsLength.close();
    imgsLength.close();
    recordId.close();
    nameController.dispose();
    pathologyController.dispose();
    nameFocusNode.dispose();
    pathologyFocusNode.dispose();
    pathologyNameStatus.close();
    super.dispose();
  }
}
