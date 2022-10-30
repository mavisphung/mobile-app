import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/storage/box.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/modules/appointment/providers/req_appointment_model.dart';

class ApiBookAppointmentImpl extends GetConnect {
  final _headers = Box.headers;

  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = Constants.baseUrl;
    httpClient.timeout = Constants.timeout;
  }

  Future<Response> getDoctorPackage(int doctorId) {
    return get(
      '/doctor/$doctorId/packages/',
      headers: _headers,
    );
  }

  Future<Response> getSuggestHours(int doctorId) {
    return get(
      '/api/suggest/doctor/$doctorId/',
      headers: _headers,
    );
  }

  Future<Response> postAppointment(ReqAppointmentModel reqModel) {
    reqModel.toString().debugLog('Req Appointment Body');
    return post(
      '/appointments/',
      reqModel.toJson(),
      headers: _headers,
    );
  }
}
