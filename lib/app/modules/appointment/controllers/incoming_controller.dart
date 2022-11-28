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

class IncomingController extends GetxController {
  late final ScrollController scrollController;
  RxList<Appointment> incomingList = <Appointment>[].obs;
  Rx<Status> loadingStatus = Status.init.obs;
  RxInt currentPage = 1.obs;

  late ApiAppointmentImpl apiAppointment;
  TextEditingController textController = TextEditingController();
  RxString rxReason = CancelReason.item1.obs;

  void clearIncomingList() {
    incomingList.clear();
    update();
  }

  void getUserIncomingAppointments({int page = 1, int limit = 10}) async {
    'loading incoming appointments'.debugLog('IncomingTab');
    Response result = await apiAppointment.getUserIncomingAppointments(page: page, limit: limit);
    var response = ApiResponse.getResponse(result); // Map
    PagingModel pageModel = PagingModel.fromMap(response);

    // Check if fetch full of the list
    if (incomingList.length >= pageModel.totalItems!) {
      return;
    }
    // check is the last page or not
    if (pageModel.nextPage != null) {
      currentPage.value = pageModel.nextPage!;
    }
    response[Constants.currentPage].toString().debugLog('Current Page');
    ResponseModel2 model = ResponseModel2.fromMap(response);
    var data = model.data as List<dynamic>;
    incomingList.value += data.map((e) {
      final appointment = Appointment(
        beginAt: e['beginAt'],
        id: e['id'],
        status: e['status'],
        category: e['category'],
        doctor: e['doctor'],
        checkInCode: e['checkInCode'],
        bookedAt: e['bookedAt'],
      );
      return appointment;
    }).toList();
    incomingList.length.toString().debugLog('Items in list');
    update();
  }

  Future<bool> cancelAppointment(int appId, String reason) async {
    var response = await apiAppointment.cancelAppointment(appId, reason);
    response.body.toString().debugLog('IncomingController#cancelAppointment: ');
    if (response.isOk) {
      incomingList.removeWhere((element) => element.id == appId);
      update();
    }
    return response.isOk == true;
  }

  void loadMore() {
    loadingStatus.value = Status.loading;
    update();
  }

  void complete() {
    loadingStatus.value = Status.success;
    update();
  }

  bool validateCancelReason() {
    loadMore();
    return textController.text.isNotEmpty;
  }

  @override
  void onInit() {
    super.onInit();
    apiAppointment = Get.put(ApiAppointmentImpl());
    scrollController = ScrollController();
    scrollController.addListener(
      () async {
        if (scrollController.position.maxScrollExtent == scrollController.offset) {
          loadMore();
          loadingStatus.value.toString().debugLog('loading status');
          getUserIncomingAppointments(page: currentPage.value);
          complete();
        }
      },
    );
    getUserIncomingAppointments(page: 1, limit: 10);
  }

  @override
  void dispose() {
    incomingList.close();
    apiAppointment.dispose();
    scrollController.dispose();
    textController.dispose();
    rxReason.close();
    super.dispose();
  }
}
