import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/storage/box.dart';
import 'package:hi_doctor_v2/app/models/other_health_record.dart';

class ApiHealthRecord extends GetConnect {
  final headers = Box.getAuthorization();

  @override
  void onInit() {
    httpClient.baseUrl = Constants.baseUrl;
    httpClient.timeout = Constants.timeout;
    super.onInit();
  }

  Future<Response> getHealthRecordWithId(int recordId) {
    return get(
      '/health-records/$recordId/',
      headers: headers,
    );
  }

  Future<Response> getHealthRecords(int patientId, {int page = 1, int limit = 10}) {
    return get(
      '/user/health-records/',
      headers: headers,
      query: {
        'page': page.toString(),
        'limit': limit.toString(),
        'patientId': patientId.toString(),
      },
    );
  }

  Future<Response> getPathologySearch(String keyword, {int page = 1, int limit = 50}) {
    return get(
      '/diseases/',
      headers: headers,
      query: {
        'page': page.toString(),
        'limit': limit.toString(),
        'keyword': keyword,
      },
    );
  }

  Future<Response> postHealthRecord(int patientId, OtherHealthRecord hr) {
    return post(
      '/user/health-records/',
      {
        "patient": patientId,
        "detail": hr.toMap(),
      },
      headers: headers,
    );
  }

  Future<Response> putHealthRecord(int hrId, int patientId, OtherHealthRecord hr) {
    return post(
      '/supervisor/health-records/$hrId/',
      {
        "patient": patientId,
        "detail": hr.toMap(),
      },
      headers: headers,
    );
  }
}
