import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/models/other_health_record.dart';
import 'package:hi_doctor_v2/app/models/pathology.dart';
import 'package:hi_doctor_v2/app/models/record.dart';
import 'package:image_picker/image_picker.dart';

class EditOtherHealthRecordController extends GetxController {
  var _pathologies = List.empty();
  List<dynamic> get getPathologies => _pathologies;

  var _records = List.empty();
  List<dynamic> get getRecords {
    if (pathologyObj.value != null) {
      return pathologyObj.value!.records;
    }
    return _records;
  }

  final _imgs = <String>[];
  List<String> get getImgs => _imgs;

  final pathologiesLength = 0.obs;
  final RxInt recordsLength = 0.obs;
  final imgsLength = 0.obs;
  final recordId = 0.obs;

  final nameController = TextEditingController();
  final nameFocusNode = FocusNode();
  Rxn<Pathology> pathologyObj = Rxn(null);

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

  void addPathology(Pathology p) {
    _pathologies.add(p);
    ++pathologiesLength.value;
    Get.back();
    for (var p in _pathologies) {
      print('\n========================');
      print(p.toString());
    }
  }

  void savePathology(Pathology p) {
    Get.back();
  }

  void removePathology(int index) async {
    final confirm = await Utils.showConfirmDialog(
      'Bệnh lý và những phiếu sức khỏe liên quan đến bệnh lý sẽ bị xóa. Bạn có chắc muốn xóa?',
      title: 'Xóa bệnh lý',
    );
    if (confirm ?? false) {
      _pathologies.removeAt(index);
      --pathologiesLength.value;
    }
  }

  void _clearImgs() {
    _imgs.clear();
    imgsLength.value = 0;
  }

  void addTicket() {
    final imgs = _imgs.toList();
    final records = getRecords;
    final existedRecordIndex = records.indexWhere((e) => e.id == recordId.value);

    if (existedRecordIndex == -1) {
      final String? typeName = recordType[recordId.value];
      final record = Record(recordId.value, typeName, imgs);
      records.add(record);
      ++recordsLength.value;
    } else {
      var tmp = records[existedRecordIndex].tickets?.toList();
      tmp?.addAll(imgs);
      if (tmp != null) records[existedRecordIndex].setTickets(tmp);
    }
    _clearImgs();
  }

  void removeTicket(int recordIndex, int index) {
    final records = getRecords;
    final record = records.elementAt(recordIndex);
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
      final records = getRecords;
      records.removeAt(index);
      --recordsLength.value;
    }
  }

  void saveOtherHealthRecord() async {
    if (nameController.text.isEmpty && (_pathologies.isEmpty || _records.isEmpty)) {
      Utils.showAlertDialog('Bạn cần đặt tên hồ sơ và thêm ít nhất một bệnh lý hoặc phiếu sức khỏe.');
      return;
    }
    final healtRecord = OtherHealthRecord(
      null,
      nameController.text.trim(),
      DateTime.now(),
      _pathologies.toList(),
      _records.toList(),
    );

    Get.back();
  }

  void initValue(OtherHealthRecord hr) {
    _pathologies = hr.pathologies ?? List.empty();
    pathologiesLength.value = _pathologies.length;
    _records = hr.otherTickets ?? List.empty();
    recordsLength.value = _records.length;
  }

  @override
  void dispose() {
    pathologiesLength.close();
    recordsLength.close();
    imgsLength.close();
    recordId.close();
    nameController.dispose();
    nameFocusNode.dispose();
    pathologyObj.close();
    super.dispose();
  }
}
