import 'dart:convert';

import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/storage/box.dart';

class ApiWalletImpl extends GetConnect {
  final headers = Box.getAuthorization();

  @override
  void onInit() {
    httpClient.baseUrl = Constants.baseUrl;
    httpClient.timeout = Constants.timeout;
    super.onInit();
  }

  Future<Response> deposit(double amount) async {
    return post(
      '/user/me/deposit/',
      headers: headers,
      json.encode({'amount': amount}),
    );
  }
}
