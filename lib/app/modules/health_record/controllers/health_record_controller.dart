import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/data/api_response.dart';
import 'package:hi_doctor_v2/app/data/response_model.dart';
import 'package:hi_doctor_v2/app/models/other_health_record.dart';
import 'package:hi_doctor_v2/app/models/patient.dart';
import 'package:hi_doctor_v2/app/modules/health_record/models/hr_res_model.dart';
import 'package:hi_doctor_v2/app/modules/health_record/providers/api_health_record.dart';

class HealthRecordController extends GetxController with GetSingleTickerProviderStateMixin {
  late final ApiHealthRecord _provider;
  late final TabController cTab;
  late final ScrollController allScroll;
  late final ScrollController systemScroll;
  late final ScrollController otherScroll;

  final List<OtherHealthRecord> _allList = <OtherHealthRecord>[];
  List<OtherHealthRecord> get getAllList => _allList.toList();
  final List<OtherHealthRecord> _systemList = <OtherHealthRecord>[];
  List<OtherHealthRecord> get getSystemList => _systemList.toList();
  final otherList = <HrResModel>[].obs;

  final patient = Patient().obs;

  Future<void> getOtherHealthRecords({int page = 1, int limit = 10}) async {
    final response = await _provider.getHealthRecords();
    final Map<String, dynamic> res = ApiResponse.getResponse(response);
    final model = ResponseModel2.fromMap(res);
    print('HR MODEL: ${model.toString()}');
    final data = model.data as List<dynamic>;

    for (var item in data) {
      if (item['patient']['id'] == (patient.value.id ?? -1) && item['record']['isPatientProvided'] == true) {
        otherList.add(HrResModel.fromMap(item));
        otherList.refresh();
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    _provider = Get.put(ApiHealthRecord());
    cTab = TabController(vsync: this, length: 3);

    allScroll = ScrollController();
    systemScroll = ScrollController();
    otherScroll = ScrollController();
    allScroll.addListener(
      () async {
        if (allScroll.position.maxScrollExtent == allScroll.offset) {}
      },
    );
    systemScroll.addListener(
      () async {
        if (systemScroll.position.maxScrollExtent == systemScroll.offset) {}
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
    allScroll.dispose();
    systemScroll.dispose();
    otherScroll.dispose();
    patient.close();
    otherList.clear();
    otherList.close();
    super.dispose();
  }
}
