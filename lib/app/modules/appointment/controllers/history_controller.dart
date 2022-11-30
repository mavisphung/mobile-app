import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/enum.dart';
import 'package:hi_doctor_v2/app/data/api_response.dart';
import 'package:hi_doctor_v2/app/data/response_model.dart';
import 'package:hi_doctor_v2/app/models/appointment.dart';
import 'package:hi_doctor_v2/app/models/paging.dart';
import 'package:hi_doctor_v2/app/modules/appointment/providers/api_appointment.dart';

class HistoryController extends GetxController {
  late final ScrollController scrollController;
  RxList<Appointment> historyList = <Appointment>[].obs;
  Rx<Status> loadingStatus = Status.init.obs;
  RxInt currentPage = 1.obs;
  int totalItems = 0;

  late ApiAppointmentImpl apiAppointment;

  void clearHistoryList() {
    currentPage.value = 1;
    totalItems = 0;
    historyList.clear();
    update();
  }

  void getUserHistoricalAppointments({int page = 1, int limit = 10}) async {
    loadMore();
    'loading historical appointments'.debugLog('HistoryTab');
    Response result = await apiAppointment.getUserHistoricalAppointments(page: page, limit: limit);
    var response = ApiResponse.getResponse(result); // Map
    PagingModel pageModel = PagingModel.fromMap(response);

    totalItems = pageModel.totalItems ?? 0;
    // check is the last page or not
    if (pageModel.nextPage != null) {
      currentPage.value = pageModel.nextPage!;
    }
    response[Constants.currentPage].toString().debugLog('Current Page');
    ResponseModel2 model = ResponseModel2.fromMap(response);
    var data = model.data as List<dynamic>;
    historyList.value += data.map((e) {
      // print(e['bookedAt']);
      return Appointment(
        beginAt: e['beginAt'],
        id: e['id'],
        status: e['status'],
        category: e['category'],
        doctor: e['doctor'],
        checkInCode: e['checkInCode'],
        bookedAt: e['bookedAt'],
      );
    }).toList();
    complete();
    historyList.length.toString().debugLog('Items in list');
    update();
  }

  void loadMore() {
    loadingStatus.value = Status.loading;
    update();
  }

  void complete() {
    loadingStatus.value = Status.success;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    apiAppointment = Get.put(ApiAppointmentImpl());
    scrollController = ScrollController();
    scrollController.addListener(
      () async {
        if (scrollController.position.maxScrollExtent == scrollController.offset) {
          if (historyList.length >= totalItems) return;
          loadMore();
          loadingStatus.value.toString().debugLog('loading status');
          getUserHistoricalAppointments(page: currentPage.value);
          complete();
        }
      },
    );
    getUserHistoricalAppointments(page: 1, limit: 10);
  }

  @override
  void dispose() {
    historyList.close();
    apiAppointment.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
