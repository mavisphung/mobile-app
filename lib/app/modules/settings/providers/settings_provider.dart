import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/storage/storage.dart';

class SettingsProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = Constants.baseUrl;
    httpClient.defaultContentType = 'application/json';
  }

  Future<Response> getUserInfo() {
    return get(
      '/user/me/',
      headers: {'Authorization': 'Bearer ${Storage.getValue<String>(CacheKey.TOKEN.name)}'},
    );
  }
}
