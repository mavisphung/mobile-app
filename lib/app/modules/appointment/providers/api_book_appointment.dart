import 'dart:convert';

import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/storage/box.dart';
import 'package:hi_doctor_v2/app/modules/appointment/providers/req_appointment_model.dart';

class ApiBookAppointmentImpl extends GetConnect {
  final _headers = Box.getAuthorization();

  @override
  void onInit() {
    httpClient.baseUrl = Constants.baseUrl;
    httpClient.timeout = Constants.timeout;

    super.onInit();
  }

  Future<Response> getDoctorPackage(int doctorId) {
    return get(
      '/doctor/$doctorId/services/',
      headers: _headers,
    );
  }

  Future<Response> getSuggestHours(int doctorId, String selectedDate) {
    return get(
      '/api/suggest/doctor/$doctorId/',
      query: {
        'date': selectedDate,
      },
      headers: _headers,
    );
  }

  Future<Response> postAppointment(ReqAppointmentModel reqModel) {
    return post(
      '/appointments/',
      reqModel.toJson(),
      headers: _headers,
    );
  }

  Future<Response> withdraw(double amount) {
    return post(
      '/user/me/withdraw/',
      json.encode({'amount': amount}),
      headers: _headers,
    );
  }
}
