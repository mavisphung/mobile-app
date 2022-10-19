import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/storage/box.dart';
import 'package:hi_doctor_v2/app/models/patient.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';
import 'package:hi_doctor_v2/app/modules/settings/providers/api_settings.dart';

class ApiSettingsImpl extends GetConnect with ApiSettings {
  final headers = Box.headers;

  @override
  void onInit() {
    httpClient.baseUrl = Constants.baseUrl;
    httpClient.timeout = Constants.timeout;
    super.onInit();
  }

  Future<Response> getProfile() {
    return get(
      '/user/me/',
      headers: headers,
    );
  }

  @override
  Future<Response> putUserProfile(UserInfo2 data) {
    return put(
      '/user/me/',
      data.toJson(),
      headers: headers,
    );
  }

  @override
  Future<Response> getPatientList({int page = 1, int limit = 10}) {
    return get(
      '/user/patients/data/',
      headers: headers,
      query: {
        'page': page.toString(),
        'limit': limit.toString(),
      },
    );
  }

  @override
  Future<Response> getPatientProfile(int patientId) {
    return get(
      '/user/patients/$patientId/',
      headers: headers,
    );
  }

  @override
  Future<Response> postPatientProfile(Patient data) {
    return post(
      '/user/patients/',
      data.toJson(),
      headers: headers,
    );
  }

  @override
  Future<Response> putPatientProfile(
    int patientId,
    Patient data,
  ) {
    return put(
      '/user/patients/$patientId',
      data.toJson(),
      headers: headers,
    );
  }
}
