import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/storage/box.dart';

class ApiHomeImpl extends GetConnect {
  final headers = Box.headers;

  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = Constants.baseUrl;
    httpClient.timeout = Constants.timeout;
  }

  Future<Response> getDoctorList({int page = 1, int limit = 10}) {
    return get(
      '/doctors/',
      headers: headers,
      query: {
        'page': page.toString(),
        'limit': limit.toString(),
      },
    );
  }
}
