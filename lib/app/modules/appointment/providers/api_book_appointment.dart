import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/storage/storage.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/modules/appointment/providers/req_appointment_model.dart';

class ApiBookAppointmentImpl extends GetConnect {
  final Map<String, String> headers = {
    'Authorization': 'Bearer ${Storage.getValue(CacheKey.TOKEN.name) ?? ""}',
  };

  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = Constants.baseUrl;
    httpClient.timeout = Constants.timeout;
  }

  Future<Response> postAppointment(ReqAppointmentModel reqModel) {
    reqModel.toString().debugLog('Req Appointment Body:');
    return post(
      '/appointments/',
      reqModel.toJson(),
      headers: headers,
    );
  }
}
