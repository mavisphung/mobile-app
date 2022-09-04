
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/storage/storage.dart';

class ApiDoctorImpl extends GetConnect{
  final Map<String, String> headers = {
    'Authorization': 'Bearer ${Storage.getValue(CacheKey.TOKEN.name) ?? ""}',
  };

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
