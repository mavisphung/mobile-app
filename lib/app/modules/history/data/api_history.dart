import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/storage/storage.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';

class ApiHistoryImpl extends GetConnect {
  late Map<String, String> headers;

  @override
  void onInit() {
    httpClient.baseUrl = Constants.baseUrl;
    httpClient.timeout = Constants.timeout;
    httpClient.defaultContentType = 'application/json';
    String token = Storage.getValue(CacheKey.TOKEN.name);
    headers = {
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getUserIncomingAppointments({int page = 1, int limit = 10}) {
    return get(
      '/user/me/appointments/',
      headers: headers,
      query: {
        'status': AppointmentStatus.pending.value,
        'page': page.toString(),
        'limit': limit.toString(),
      },
    );
  }
}
