import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/storage/storage.dart';
import 'package:hi_doctor_v2/app/models/service.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';
import 'package:intl/intl.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/data/api_response.dart';
import 'package:hi_doctor_v2/app/data/response_model.dart';
import 'package:hi_doctor_v2/app/models/doctor.dart';
import 'package:hi_doctor_v2/app/models/patient.dart';
import 'package:hi_doctor_v2/app/modules/appointment/providers/api_book_appointment.dart';
import 'package:hi_doctor_v2/app/modules/appointment/providers/req_appointment_model.dart';

class BookingController extends GetxController {
  // select booking date time
  Rx<DateTime> rxSelectedDate = DateTime.now().obs;
  Rx<DateTime> rxFocusedDate = DateTime.now().obs;
  RxInt rxSelectedTimeId = 0.obs;

  // selected service
  final Rx<Service> _rxService = Service().obs;
  Service get selectedService => _rxService.value;
  String _selectedTime = '';

  // payment status
  RxBool rxPaymentStatus = false.obs;

  bool get paymentStatus => rxPaymentStatus.value;

  DateTime get selectedDate => rxSelectedDate.value;
  DateTime get focusedDate => rxSelectedDate.value;

  int get selectedTimeId => rxSelectedTimeId.value;

  String get selectedTime => _selectedTime;

  void setPaymentStatus(bool value) {
    rxPaymentStatus.value = value;
    rxPaymentStatus.value.toString().debugLog('PaymentStatus');
    update();
  }

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
    _rxService.value = packageList!.firstWhere((service) => service.id == serviceId);
    update();
  }

  List<Service>? packageList;

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

  Future<List<dynamic>?> getSuggestHours() async {
    final response = await _apiBookAppointment.getSuggestHours(_doctor.id!, DateFormat('yyyy-MM-dd').format(selectedDate)).futureValue();
    if (response != null && response.isSuccess == true && response.statusCode == Constants.successGetStatusCode) {
      final data = response.data;
      // if (data is Map) {
      //   if (data.isEmpty) return List.empty();
      // } else if (data is List<Map<String, dynamic>>) {
      //   return data;
      // }
      if (data == null || data is Map || (data as List<dynamic>).isEmpty) {
        return List.empty();
      }

      return data;
    }
    return null;
  }

  Future<bool?> getPackages(int doctorId) async {
    final result = await _apiBookAppointment.getDoctorPackage(doctorId);
    final Map<String, dynamic> response = ApiResponse.getResponse(result);
    final ResponseModel2 model = ResponseModel2.fromMap(response);
    if (model.success == true && model.status == Constants.successGetStatusCode) {
      var data = model.data as List<dynamic>?;
      if (data == null || data.isEmpty) return true;
      packageList = data.map((e) {
        dynamic data = e['service'] as Map<String, dynamic>;
        return Service.fromMap(data);
      }).toList();
      setServiceId(packageList![0].id!);
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

  Future<bool> withdraw(double amount) async {
    final response = await _apiBookAppointment.withdraw(amount).futureValue();
    if (response == null) {
      return false;
    }

    if (response.statusCode < 200 || response.statusCode > 299) {
      return false;
    }
    UserInfo2 newInfo = UserInfo2.fromMap(response.data);
    await Storage.saveValue(CacheKey.USER_INFO.name, newInfo);
    return true;
  }

  @override
  void dispose() {
    // select booking date time
    rxSelectedDate.close();
    rxFocusedDate.close();
    rxSelectedTimeId.close();

    // select service package
    rxServiceId.close();
    _rxService.close();

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
