import 'dart:convert';

import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';

class ApiContract extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = Constants.baseUrl;
    httpClient.timeout = Constants.timeout;

    httpClient.addRequestModifier<dynamic>((request) {
      printInfo(
        info: 'REQUEST ║ ${request.method.toUpperCase()}\n'
            'url: ${request.url}\n'
            'Headers: ${request.headers}\n'
            'Body: ${request.files?.toString() ?? ''}\n',
      );
      return request;
    });
    super.onInit();
  }

  @override
  Future<Response> postContract(Map<String, dynamic> map) {
    return post(
      '/contract/',
      json.encode(map),
    );
  }
}
