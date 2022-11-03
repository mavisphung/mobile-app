import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/models/other_health_record.dart';
import 'package:hi_doctor_v2/app/models/patient.dart';
import 'package:hi_doctor_v2/app/modules/health_record/providers/api_health_record.dart';
import 'package:hi_doctor_v2/app/modules/health_record/views/other_tab.dart';

class HealthRecordController extends GetxController with GetSingleTickerProviderStateMixin {
  late final ApiHealthRecord _apiHealthRecord;
  late final TabController cTab;
  late final ScrollController allScroll;
  late final ScrollController systemScroll;
  late final ScrollController otherScroll;

  List<OtherHealthRecord> _allList = <OtherHealthRecord>[];
  List<OtherHealthRecord> get getAllList => _allList.toList();
  List<OtherHealthRecord> _systemList = <OtherHealthRecord>[];
  List<OtherHealthRecord> get getSystemList => _systemList.toList();
  List<OtherHealthRecord> _otherList = <OtherHealthRecord>[];
  List<OtherHealthRecord> get getOtherList => _otherList.toList();
  final otherListLength = 0.obs;

  final patient = Patient().obs;

  Future<bool> getOtherHealthRecords({int page = 1, int limit = 10}) async {
    await Future.delayed(const Duration(seconds: 3));
    _otherList = hrList.toList();
    otherListLength.value = _otherList.length;
    print('VALUE: ${otherListLength.value}');
    return true;
  }

  Future<bool> createHealthRecord(OtherHealthRecord hr) async {
    await _apiHealthRecord.postHealthRecord(hr);
    return false;
  }

  @override
  void onInit() {
    super.onInit();
    _apiHealthRecord = Get.put(ApiHealthRecord());
    cTab = TabController(vsync: this, length: 3);

    allScroll = ScrollController();
    systemScroll = ScrollController();
    otherScroll = ScrollController();
    allScroll.addListener(
      () async {
        if (allScroll.position.maxScrollExtent == allScroll.offset) {
          // await getOtherHealthRecords();
        }
      },
    );
    systemScroll.addListener(
      () async {
        if (systemScroll.position.maxScrollExtent == systemScroll.offset) {
          // await getOtherHealthRecords();
        }
      },
    );
    otherScroll.addListener(
      () async {
        if (otherScroll.position.maxScrollExtent == otherScroll.offset) {
          await getOtherHealthRecords();
        }
      },
    );
    getOtherHealthRecords();
  }

  @override
  void dispose() {
    cTab.dispose();
    otherListLength.close();
    allScroll.dispose();
    systemScroll.dispose();
    otherScroll.dispose();
    patient.close();
    super.dispose();
  }
}
