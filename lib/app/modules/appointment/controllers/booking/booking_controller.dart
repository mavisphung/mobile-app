import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/data/api_response.dart';
import 'package:hi_doctor_v2/app/data/response_model.dart';
import 'package:hi_doctor_v2/app/models/doctor.dart';
import 'package:hi_doctor_v2/app/models/patient.dart';
import 'package:hi_doctor_v2/app/modules/appointment/providers/api_book_appointment.dart';
import 'package:hi_doctor_v2/app/modules/appointment/providers/req_appointment_model.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/package_item.dart';

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

  final RxInt rxServiceId = 0.obs;

  int get serviceId => rxServiceId.value;

  void setServiceId(int serviceId) {
    rxServiceId.value = serviceId;
  }

  List<PackageItem>? packageList;

  // patient detail
  final problemController = TextEditingController();

  // booking summary
  late final ApiBookAppointmentImpl _apiBookAppointment;

  late Doctor _doctor;
  Doctor get doctor => _doctor;
  void setDoctor(value) {
    _doctor = value;
  }

  final rxPatient = Rxn<Patient>();
  Patient? get patient => rxPatient.value;
  void setPatient(Patient value) {
    rxPatient.value = value;
  }

  Future<List<Map<String, dynamic>>?> getSuggestHours() async {
    final response = await _apiBookAppointment
        .getSuggestHours(_doctor.id!, DateFormat('yyyy-MM-dd').format(selectedDate))
        .futureValue();
    if (response != null && response.isSuccess == true && response.statusCode == Constants.successGetStatusCode) {
      final data = response.data;
      print(response.data.toString());
      if (data is Map) {
        if (data.isEmpty) return List.empty();
      } else if (data is List<Map<String, dynamic>>) {
        return data;
      }
    }
    return null;
  }

  Future<bool?> getPackages(int doctorId) async {
    final result = await _apiBookAppointment.getDoctorPackage(doctorId);
    final Map<String, dynamic> response = ApiResponse.getResponse(result);
    final ResponseModel2 model = ResponseModel2.fromMap(response);
    if (model.success == true && model.status == Constants.successGetStatusCode) {
      final data = model.data as List<dynamic>?;
      if (data == null || data.isEmpty) return true;
      packageList = data
          .map((e) => PackageItem(
                id: e['service']['id'],
                name: e['service']['name'],
                description: e['service']['description'],
                price: e['service']['price'],
                category: e['service']['category'],
              ))
          .toList();
      setServiceId(data[0]['id']);
      return true;
    } else if (model.success == false) {
      packageList = null;
      return false;
    }
    return null;
  }

  Future<bool?> createAppointment(ReqAppointmentModel reqModel) async {
    'Creating appointment'.debugLog('BookingController');
    final response = await _apiBookAppointment.postAppointment(reqModel).futureValue();
    response.toString().debugLog('BookingController.response');
    if (response != null) {
      if (response.isSuccess == true && response.statusCode == 201) {
        return true;
      } else if (response.message == 'APPOINTMENT_DUPLICATED') {
        return false;
      }
    }
    return null;
  }

  @override
  void dispose() {
    // select booking date time
    rxSelectedDate.close();
    rxFocusedDate.close();
    rxSelectedTimeId.close();

    // select service package
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
