import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/models/health_record.dart';
import 'package:hi_doctor_v2/app/modules/health_record/views/onther_tab.dart';

class HealthRecordController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController cTab;
  late final ScrollController scrollController;

  List<HealthRecord> _otherList = <HealthRecord>[];
  List<HealthRecord> get getOtherList => _otherList;

  Future<bool> getOtherHealthRecords({int page = 1, int limit = 10}) async {
    await Future.delayed(const Duration(seconds: 3));
    print('LENGTH: ${hrList.length}');
    _otherList = hrList;
    return true;
  }

  @override
  void onInit() {
    super.onInit();
    cTab = TabController(vsync: this, length: 3);

    scrollController = ScrollController();
    scrollController.addListener(
      () async {
        if (scrollController.position.maxScrollExtent == scrollController.offset) {
          // the bottom of the scrollbar is reached
          // adding more widgets
          // 'Reach the bottom'.debugLog('ScrollController');
          getOtherHealthRecords();
        }
      },
    );
    getOtherHealthRecords();
  }

  @override
  void dispose() {
    cTab.dispose();
    super.dispose();
  }
}
