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

  Future<Response> getSpecialists({int page = 1, int limit = 10}) {
    return get(
      '/specialists/',
      headers: headers,
      query: {
        'page': page.toString(),
        'limit': limit.toString(),
      },
    );
  }

  Future<Response> getNearestDoctors({
    String address = '218 Hồng Bàng, Phường 15, Quận 5, Thành phố Hồ Chí Minh, Việt Nam',
    int page = 1,
    int limit = 10,
  }) {
    return get(
      '/doctors/nearest/',
      headers: headers,
      query: {
        'page': page.toString(),
        'limit': limit.toString(),
        'address': address,
      },
    );
  }
}
