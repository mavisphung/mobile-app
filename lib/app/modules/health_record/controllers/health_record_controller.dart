import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/enum.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';

import 'package:hi_doctor_v2/app/data/api_response.dart';
import 'package:hi_doctor_v2/app/data/response_model.dart';
import 'package:hi_doctor_v2/app/models/patient.dart';
import 'package:hi_doctor_v2/app/modules/health_record/models/hr_res_model.dart';
import 'package:hi_doctor_v2/app/modules/health_record/models/system_hr_res_model.dart';
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

  Status status = Status.init;
  SystemHrResModel? systemHrResModel;

  int? _nextPage = 1;
  int _totalItems = 0;

  void reset() {
    allList.clear();
    systemList.clear();
    otherList.clear();
    _nextPage = 1;
    _totalItems = 0;
  }

  Future<bool?> getHrWithId(int recordId) async {
    var response = await _provider.getHealthRecordWithId(recordId).futureValue();

    if (response?.isSuccess == true) {
      final data = response!.data as Map<String, dynamic>;
      systemHrResModel = SystemHrResModel.fromMap(data);
      return true;
    } else if (response?.isSuccess == false) {
      return false;
    }
    return null;
  }

  Future<void> getAllHealthRecords({int page = 1, int limit = 10}) async {
    if (rxPatient.value?.id == null) return;
    status = Status.loading;
    final response = await _provider.getHealthRecords(rxPatient.value!.id!, page: page, limit: limit);
    final Map<String, dynamic> res = ApiResponse.getResponse(response);
    final model = ResponseModel2.fromMap(res);

    _nextPage = model.nextPage;
    if (model.totalItems != null) _totalItems = model.totalItems!;

    final data = model.data as List<dynamic>;
    status = Status.success;

    for (var item in data) {
      if (item['record']['isPatientProvided'] == true) {
        otherList.add(HrResModel.fromMap(item));
      }
      if (item['record']['isPatientProvided'] == false) {
        systemList.add(HrResModel.fromMap(item));
      }
      allList.add(HrResModel.fromMap(item));
      otherList.refresh();
      systemList.refresh();
      allList.refresh();
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
        if (allScroll.position.maxScrollExtent == allScroll.offset) {
          if (allList.length >= _totalItems) return;
          if (_nextPage != null) await getAllHealthRecords(page: _nextPage!);
        }
      },
    );
    systemScroll.addListener(
      () async {
        if (systemScroll.position.maxScrollExtent == systemScroll.offset) {
          if (allList.length >= _totalItems) return;
          if (_nextPage != null) await getAllHealthRecords(page: _nextPage!);
        }
      },
    );
    otherScroll.addListener(
      () async {
        if (otherScroll.position.maxScrollExtent == otherScroll.offset) {
          if (allList.length >= _totalItems) return;
          if (_nextPage != null) await getAllHealthRecords(page: _nextPage!);
        }
      },
    );
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
