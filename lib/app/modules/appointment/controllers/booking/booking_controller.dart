import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/data/api_response.dart';
import 'package:hi_doctor_v2/app/data/response_model.dart';
import 'package:hi_doctor_v2/app/models/doctor.dart';
import 'package:hi_doctor_v2/app/models/patient.dart';
import 'package:hi_doctor_v2/app/modules/appointment/providers/api_book_appointment.dart';
import 'package:hi_doctor_v2/app/modules/appointment/providers/req_appointment_model.dart';
import 'package:hi_doctor_v2/app/modules/appointment/views/booking/booking_package_page.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/service_item.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class BookingController extends GetxController {
  // select booking date time
  Rx<DateTime> rxSelectedDate = DateTime.now().obs;
  Rx<DateTime> rxFocusedDate = DateTime.now().obs;
  RxInt rxSelectedTimeId = 0.obs;
  String _selectedTime = '';

  DateTime get selectedDate => rxSelectedDate.value;
  DateTime get focusedDate => rxSelectedDate.value;

  int get selectedTimeId => rxSelectedTimeId.value;

  String get selectedTime => _selectedTime;

  void setSelectedTime(String value) {
    _selectedTime = value;
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
  final Rx<PackageType> rxServiceType = PackageType.online.obs;

  String get serviceType {
    if (rxServiceType.value.index == 0) return 'ONLINE';
    return 'OFFLINE';
  }

  void setServiceType(PackageType serviceType) {
    rxServiceType.value = serviceType;
  }

  final RxInt rxServiceId = 0.obs;

  int get serviceId => rxServiceId.value;

  void setServiceId(int serviceId) {
    rxServiceId.value = serviceId;
  }

  late List<PackageItem>? packageList;

  // patient detail
  final problemController = TextEditingController();

  // booking summary
  late final ApiBookAppointmentImpl _apiBookAppointment;

  late Doctor _doctor;
  Doctor get doctor => _doctor;
  void setDoctor(value) {
    _doctor = value;
  }

  final rxPatient = Patient().obs;
  Patient get patient => rxPatient.value;
  void setPatient(value) {
    rxPatient.value = value;
  }

  Future<List<PackageItem>?> getPackages(int doctorId) async {
    final result = await _apiBookAppointment.getDoctorPackage(doctorId);
    final Map<String, dynamic> response = ApiResponse.getResponse(result);
    final ResponseModel2 model = ResponseModel2.fromMap(response);
    if (model.success == true && model.status == Constants.successGetStatusCode) {
      final data = model.data as List<dynamic>;
      packageList = data
          .map((e) => PackageItem(
                id: e['id'],
                name: e['name'],
                description: e['description'],
                price: e['price'],
              ))
          .toList();
      setServiceId(data[0]['id']);
    } else {
      packageList = null;
    }
    return packageList;
  }

  Future<Map<String, dynamic>> createAppointment(ReqAppointmentModel reqModel) async {
    'Creating appointment'.debugLog('BookingController');
    final response = await _apiBookAppointment.postAppointment(reqModel).futureValue();
    response.toString().debugLog('BookingController.response');
    Map<String, dynamic> result = {};
    if (response != null) {
      if (response.isSuccess == true && response.statusCode == 201) {
        result['status'] = 200;
        result['message'] = 'APPOINTMENT_CREATED_SUCCEEDED';
      } else if (response.message == 'APPOINTMENT_DUPLICATED') {
        result['status'] = 400;
        result['message'] = response.message;
      }
    }
    return result;
  }

  @override
  void dispose() {
    // select booking date time
    rxSelectedDate.close();
    rxFocusedDate.close();
    rxSelectedTimeId.close();

    // select service package
    rxServiceType.close();
    rxServiceId.close();

    // patient detail
    problemController.dispose();
    _apiBookAppointment.dispose();
    rxPatient.close();
    super.dispose();
  }

  @override
  void onInit() {
    _apiBookAppointment = Get.put(ApiBookAppointmentImpl());
    super.onInit();
  }
}
