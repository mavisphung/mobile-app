import 'dart:convert';

import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/storage/box.dart';

class ApiContract extends GetConnect {
  final headers = Box.getAuthorization();

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

  Future<Response> postContract(Map<String, dynamic> map) {
    return post(
      '/contract/',
      json.encode(map),
      headers: headers,
    );
  }

  Future<Response> getFilterContract(String status, {int page = 1, int limit = 10}) {
    return get(
      '/contract/supervisor/list',
      headers: headers,
      query: {
        'page': page.toString(),
        'limit': limit.toString(),
        'status': status,
      },
    );
  }
}
