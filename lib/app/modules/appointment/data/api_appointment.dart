import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/storage/storage.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';

class ApiAppointmentImpl extends GetConnect {
  final Map<String, String> headers = {
    'Authorization': 'Bearer ${Storage.getValue(CacheKey.TOKEN.name) ?? ""}',
  };

  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = Constants.baseUrl;
    httpClient.timeout = Constants.timeout;
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

  Future<Response> getUserHistoricalAppointments({int page = 1, int limit = 10}) {
    return get(
      '/user/me/appointments/history/',
      headers: headers,
      query: {
        'page': page.toString(),
        'limit': limit.toString(),
      },
    );
  }
}
