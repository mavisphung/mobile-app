import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/storage/box.dart';
import 'package:hi_doctor_v2/app/models/other_health_record.dart';

class ApiHealthRecord extends GetConnect {
  final headers = Box.headers;

  @override
  void onInit() {
    httpClient.baseUrl = Constants.baseUrl;
    httpClient.timeout = Constants.timeout;
    super.onInit();
  }

  Future<Response> getPathologySearch(String keyword, {int page = 1, int limit = 10}) {
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
}
