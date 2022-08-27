import 'package:get/get.dart';

import '../../common/constants.dart';
import './api_settings.dart';

class ApiSettingsImpl extends GetConnect with ApiSettings {
  @override
  void onInit() {
    httpClient.baseUrl = Constants.baseUrl;
    httpClient.timeout = Constants.timeout;
    httpClient.defaultContentType = 'application/json';
  }

  @override
  Future<Response> getUserInfo(String accessToken) {
    return get(
      '/user/me/',
      headers: {'Authorization': 'Bearer $accessToken'},
    );
  }
}
