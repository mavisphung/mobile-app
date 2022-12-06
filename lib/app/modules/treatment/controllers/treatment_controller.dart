import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/enum.dart';
import 'package:hi_doctor_v2/app/models/appointment.dart';
import 'package:hi_doctor_v2/app/modules/health_record/models/hr_res_model.dart';
import 'package:hi_doctor_v2/app/modules/treatment/views/records_tab.dart';
import 'package:hi_doctor_v2/app/modules/treatment/views/schedule_tab.dart';

class TreatmentController extends GetxController with GetSingleTickerProviderStateMixin {
  late final TabController cTab;
  RxList<Appointment> appointmentList = <Appointment>[].obs;
  RxList<HrResModel> systemHrList = <HrResModel>[].obs;

  // scroll controller
  late final ScrollController scrollController1;
  late final ScrollController scrollController2;

  Status tab1LoadingStatus = Status.init;
  Status tab2LoadingStatus = Status.init;

  // late ApiAppointmentImpl apiAppointment;

  void clearAppointmentList() {
    appointmentList.clear();
  }

  void clearSystemHrList() {
    systemHrList.clear();
  }

  void getAppointments({int page = 1, int limit = 10}) async {
    tab1LoadingStatus = Status.loading;
    Future.delayed(const Duration(seconds: 3));
    // Response result = await apiAppointment.getUserHistoricalAppointments(page: page, limit: limit);
    // var response = ApiResponse.getResponse(result);
    // ResponseModel2 model = ResponseModel2.fromMap(response);
    // var data = model.data as List<dynamic>;
    // appointmentList.value += data.map((e) {
    //   return Appointment(
    //     beginAt: e['beginAt'],
    //     id: e['id'],
    //     status: e['status'],
    //     category: e['category'],
    //     doctor: e['doctor'],
    //     checkInCode: e['checkInCode'],
    //     bookedAt: e['bookedAt'],
    //   );
    // }).toList();
    appointmentList.value = mockAppointmentList;
    tab1LoadingStatus = Status.success;
  }

  void getSystemHr({int page = 1, int limit = 10}) async {
    tab2LoadingStatus = Status.loading;
    Future.delayed(const Duration(seconds: 5));
    // Response result = await apiAppointment.getUserHistoricalAppointments(page: page, limit: limit);
    // var response = ApiResponse.getResponse(result);
    // ResponseModel2 model = ResponseModel2.fromMap(response);
    // var data = model.data as List<dynamic>;
    // appointmentList.value += data.map((e) {
    //   return Appointment(
    //     beginAt: e['beginAt'],
    //     id: e['id'],
    //     status: e['status'],
    //     category: e['category'],
    //     doctor: e['doctor'],
    //     checkInCode: e['checkInCode'],
    //     bookedAt: e['bookedAt'],
    //   );
    // }).toList();
    systemHrList.value = mockHrList;
    tab2LoadingStatus = Status.success;
  }

  @override
  void onInit() {
    super.onInit();
    cTab = TabController(vsync: this, length: 2);
    scrollController1 = ScrollController();
    scrollController1.addListener(() {
      'Scrolling...'.debugLog('Schedule Tab Scroll Controller');
    });
    scrollController2 = ScrollController();
    scrollController2.addListener(() {
      'Scrolling...'.debugLog('Records Tab Scroll Controller');
    });
    // apiAppointment = Get.put(ApiAppointmentImpl());
    getAppointments(page: 1, limit: 10);
    getSystemHr();
  }

  @override
  void dispose() {
    cTab.dispose();
    scrollController1.dispose();
    scrollController2.dispose();
    appointmentList.clear();
    appointmentList.close();
    systemHrList.clear();
    systemHrList.close();
    super.dispose();
  }
}
