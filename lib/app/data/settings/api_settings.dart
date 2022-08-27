import 'package:get/get.dart';

abstract class ApiSettings {
  // static ApiSettings get apiObj => Get.find();

  Future<Response> getUserInfo(String accessToken);
}
