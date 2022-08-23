import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/storage/storage.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';

class SettingsProvider extends GetConnect {
  late final String token;

  @override
  void onInit() {
    httpClient.baseUrl = Constants.baseUrl;
    httpClient.defaultContentType = 'application/json';
    token = Storage.getValue<String>(CacheKey.TOKEN.name)!;
  }

  Future<Response> getUserInfo() {
    return get(
      '/user/me/',
      headers: {'Authorization': 'Bearer $token'},
    );
  }
}
