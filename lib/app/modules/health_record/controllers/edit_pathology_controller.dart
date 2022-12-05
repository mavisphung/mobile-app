import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:hi_doctor_v2/app/routes/app_pages.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/models/pathology.dart';
import 'package:hi_doctor_v2/app/models/record.dart';
import 'package:hi_doctor_v2/app/modules/health_record/controllers/edit_health_record_controller.dart';

class EditPathologyController extends GetxController {
  final _picker = ImagePicker();
  final recordId = 0.obs;

  late final EditOtherHealthRecordController _cEditOtherHealthRecord;

  late final Pathology _p;

  late final RxList<Record> _records;
  RxList<Record> get rxRecords => _records;

  final imgs = RxList<XFile>();

  Future<bool> initialize(Pathology p) {
    _p = p;
    _records = p.records!.toList().obs;
    return Future.value(true);
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

  void addPathology() {
    final p = Pathology(_p.id, _p.code, _p.otherCode, _p.generalName, _p.diseaseName, _records);
    _cEditOtherHealthRecord.rxPathologies.add(p);
    _cEditOtherHealthRecord.rxPathologies.refresh();
    Get.until((route) => Get.currentRoute == Routes.EDIT_HEALTH_RECORD);
  }

  void updatePathology() {
    final existedItem = _cEditOtherHealthRecord.rxPathologies.indexWhere((e) => e.id == _p.id);
    _cEditOtherHealthRecord.rxPathologies.setAll(existedItem, [_p]);
    Get.until((route) => Get.currentRoute == Routes.EDIT_HEALTH_RECORD);
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

  @override
  void onInit() {
    _cEditOtherHealthRecord = Get.find<EditOtherHealthRecordController>();
    super.onInit();
  }

  @override
  void dispose() {
    _records.clear();
    _records.close();
    imgs.clear();
    imgs.close();
    recordId.close();
    _cEditOtherHealthRecord.dispose();
    super.dispose();
  }
}
