import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/storage/box.dart';

class ApiDoctorImpl extends GetConnect {
  final headers = Box.headers;

  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = Constants.baseUrl;
    httpClient.timeout = Constants.timeout;
  }

  Future<Response> getDoctorWithId(int doctorId) {
    return get(
      '/doctor/$doctorId/',
      headers: headers,
    );
  }
}
