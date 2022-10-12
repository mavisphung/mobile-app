import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/storage/box.dart';

class ApiMeeting extends GetConnect {
  final headers = Box.headers;

  @override
  void onInit() {
    httpClient.baseUrl = Constants.baseUrl;
    httpClient.timeout = Constants.timeout;
    super.onInit();
  }

  Future<Response> getAgoraChannelToken() {
    return get(
      '/user/me/agora-token/',
      headers: headers,
    );
  }

  Future<Response> getAppointmentWithId(int id) {
    return get(
      '/appointments/$id/',
      headers: headers,
    );
  }
}
