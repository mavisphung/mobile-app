import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/data/api_response.dart';
import 'package:hi_doctor_v2/app/data/response_model.dart';
import 'package:hi_doctor_v2/app/models/patient.dart';
import 'package:hi_doctor_v2/app/modules/health_record/models/hr_res_model.dart';
import 'package:hi_doctor_v2/app/modules/health_record/providers/api_health_record.dart';

class HealthRecordController extends GetxController with GetSingleTickerProviderStateMixin {
  late final ApiHealthRecord _provider;
  late final TabController cTab;
  late final ScrollController allScroll;
  late final ScrollController systemScroll;
  late final ScrollController otherScroll;

  final allList = <HrResModel>[].obs;
  final systemList = <HrResModel>[].obs;
  final otherList = <HrResModel>[].obs;

  final rxPatient = Rxn<Patient>();

  int? _nextPage = 1;

  Future<void> getSystemHealthRecords({int page = 1, int limit = 10}) async {
    if (rxPatient.value?.id == null) {
      print('NULL');
      return;
    }
    final response = await _provider.getHealthRecords(rxPatient.value!.id!, page: page, limit: limit);
    final Map<String, dynamic> res = ApiResponse.getResponse(response);
    final model = ResponseModel2.fromMap(res);

    _nextPage = model.nextPage;

    print('HR MODEL: ${model.toString()}');

    final data = model.data as List<dynamic>;

    for (var item in data) {
      print('DATA: ${data.toString()}');
      if (item['record']['isPatientProvided'] == false) {
        systemList.add(HrResModel.fromMap(item));
        systemList.refresh();
      }
    }
  }

  Future<void> getOtherHealthRecords({int page = 1, int limit = 10}) async {
    if (rxPatient.value?.id == null) return;
    final response = await _provider.getHealthRecords(rxPatient.value!.id!, page: page, limit: limit);
    final Map<String, dynamic> res = ApiResponse.getResponse(response);
    final model = ResponseModel2.fromMap(res);

    _nextPage = model.nextPage;

    // print('HR MODEL: ${model.toString()}');

    final data = model.data as List<dynamic>;

    for (var item in data) {
      if (item['record']['isPatientProvided'] == true) {
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
        if (systemScroll.position.maxScrollExtent == systemScroll.offset) {
          if (_nextPage != null) await getSystemHealthRecords(page: _nextPage!);
        }
      },
    );
    otherScroll.addListener(
      () async {
        if (otherScroll.position.maxScrollExtent == otherScroll.offset) {
          if (_nextPage != null) await getOtherHealthRecords(page: _nextPage!);
        }
      },
    );
    // getOtherHealthRecords();
    getSystemHealthRecords();
  }

  @override
  void dispose() {
    cTab.dispose();
    allScroll.dispose();
    systemScroll.dispose();
    otherScroll.dispose();
    rxPatient.close();
    allList.clear();
    allList.close();
    systemList.clear();
    systemList.close();
    otherList.clear();
    otherList.close();
    super.dispose();
  }
}
