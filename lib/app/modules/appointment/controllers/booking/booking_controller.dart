import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/modules/appointment/providers/api_book_appointment.dart';
import 'package:hi_doctor_v2/app/modules/appointment/providers/req_appointment_model.dart';

class BookingController extends GetxController {
  // select booking date time
  Rx<DateTime> rxSelectedDate = DateTime.now().obs;
  Rx<DateTime> rxFocusedDate = DateTime.now().obs;
  RxBool rxIsSelected = false.obs;
  RxInt rxSelectedTimeId = 0.obs;

  DateTime get selectedDate => rxSelectedDate.value;
  DateTime get focusedDate => rxSelectedDate.value;

  bool get isSelected => rxIsSelected.value;
  int get selectedTimeId => rxSelectedTimeId.value;

  String _selectedTime = '';
  String get selectedTime => _selectedTime;
  set selectedTime(newValue) {
    _selectedTime = newValue;
  }

  void setSelectedTimeId(int value) {
    rxSelectedTimeId.value = value;
    update();
  }

  void setSelectedDate(DateTime value) {
    rxSelectedDate.value = value;
  }

  void setFocusedDate(DateTime value) {
    rxFocusedDate.value = value;
  }

  // select service package
  RxInt rxServiceId = 0.obs;

  int get serviceId => rxServiceId.value;

  set serviceId(int serviceId) {
    rxServiceId.value = serviceId;
    update();
  }

  // patient detail
  final problemController = TextEditingController();

  // booking summary
  late final ApiBookAppointmentImpl _apiBookAppointment;

  void createAppointment(ReqAppointmentModel reqModel) async {
    final response = await _apiBookAppointment.postAppointment(reqModel).futureValue();
    if (response != null) {
      if (response.isSuccess == true && response.statusCode == Constants.successGetStatusCode) {
        Utils.showAlertDialog(response.toString());
        return;
      }
    }
    Utils.showAlertDialog(response.toString());
  }

  @override
  void dispose() {
    // select booking date time
    rxSelectedDate.close();
    rxFocusedDate.close();
    rxIsSelected.close();
    rxSelectedTimeId.close();

    // select service package
    rxServiceId.close();

    // patient detail
    problemController.dispose();
    _apiBookAppointment.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    _apiBookAppointment = Get.put(ApiBookAppointmentImpl());
    super.onInit();
  }
}
