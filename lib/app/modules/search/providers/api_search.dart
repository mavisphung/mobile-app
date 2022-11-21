import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';

class ApiSearch extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = Constants.baseUrl;
    httpClient.timeout = Constants.timeout;
    super.onInit();
  }

  Future<Response> getSearchDoctors({int page = 1, int limit = 10, required String query}) {
    return get(
      '/api/doctor/search/',
      query: {
        'page': page.toString(),
        'limit': limit.toString(),
        'q': query,
      },
    );
  }
}
